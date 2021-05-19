package ca.uhn.fhir.jpa.starter;

import ca.uhn.fhir.jpa.rp.r4.PersonResourceProvider;
import ca.uhn.fhir.jpa.starter.auth.PkbConsentService;
import ca.uhn.fhir.jpa.subscription.channel.config.SubscriptionChannelConfig;
import ca.uhn.fhir.jpa.subscription.match.config.SubscriptionProcessorConfig;
import ca.uhn.fhir.jpa.subscription.match.config.WebsocketDispatcherConfig;
import ca.uhn.fhir.jpa.subscription.submit.config.SubscriptionSubmitterConfig;
import com.osohq.oso.Oso;
import org.apache.commons.io.IOUtils;
import org.hl7.fhir.r4.model.DomainResource;
import org.hl7.fhir.r4.model.IdType;
import org.hl7.fhir.r4.model.Immunization;
import org.hl7.fhir.r4.model.Person;
import org.keycloak.adapters.servlet.KeycloakOIDCFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.beans.factory.config.AutowireCapableBeanFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.elasticsearch.ElasticsearchRestClientAutoConfiguration;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Import;
import org.springframework.core.io.Resource;

import java.io.IOException;
import java.nio.charset.StandardCharsets;

@ServletComponentScan(basePackageClasses = {JpaRestfulServer.class})
@SpringBootApplication(exclude = {ElasticsearchRestClientAutoConfiguration.class})
@Import({SubscriptionSubmitterConfig.class, SubscriptionProcessorConfig.class, SubscriptionChannelConfig.class, WebsocketDispatcherConfig.class })
public class Application extends SpringBootServletInitializer {
	public static void main(String[] args) {
		System.setProperty("spring.batch.job.enabled", "false");
		SpringApplication.run(Application.class, args);
	}

	@Override
	protected SpringApplicationBuilder configure(
		SpringApplicationBuilder builder) {
		return builder.sources(Application.class);
	}

	@Autowired
	AutowireCapableBeanFactory beanFactory;

	@Bean
	public Oso setupOso(@Value("classpath:authorization.polar") Resource resource) throws IOException {
		Oso oso = new Oso();
		oso.registerClass(Person.class, "Person");
		oso.registerClass(DomainResource.class, "DomainResource");
		oso.registerClass(org.hl7.fhir.r4.model.Resource.class, "Resource");
		oso.registerClass(IdType.class, "IdType");
		oso.registerClass(Immunization.class, "Immunization");
		oso.loadStr(IOUtils.toString(resource.getInputStream(), StandardCharsets.UTF_8), resource.getFilename());
		return oso;
	}
	
	@Bean
	public PkbConsentService pkbConsentService(PersonResourceProvider personResourceProvider, Oso oso) {
		return new PkbConsentService(personResourceProvider, oso);
	}
	
	@Bean
	public JpaRestfulServer jpaRestfulServer(PkbConsentService pkbConsentService) {
		JpaRestfulServer jpaRestfulServer = new JpaRestfulServer(pkbConsentService);
		beanFactory.autowireBean(jpaRestfulServer);
		return jpaRestfulServer;
	} 

	@Bean
	public ServletRegistrationBean<JpaRestfulServer> hapiServletRegistration(JpaRestfulServer jpaRestfulServer) {
		ServletRegistrationBean<JpaRestfulServer> servletRegistrationBean = new ServletRegistrationBean<>();
		servletRegistrationBean.setServlet(jpaRestfulServer);
		servletRegistrationBean.addUrlMappings("/fhir/*");
		servletRegistrationBean.setLoadOnStartup(1);
		return servletRegistrationBean;
	}

	@Bean
	public FilterRegistrationBean<KeycloakOIDCFilter> keycloakFilterRegistration() {
		FilterRegistrationBean<KeycloakOIDCFilter> registration = new FilterRegistrationBean<>();
		registration.setFilter(new KeycloakOIDCFilter());
		registration.addUrlPatterns("/fhir/*");
		registration.addUrlPatterns("/keycloak/*");
		registration.addInitParameter("keycloak.config.skipPattern", "/fhir/metadata");
		registration.setName("Keycloak Filter");
		return registration;
	}
}
