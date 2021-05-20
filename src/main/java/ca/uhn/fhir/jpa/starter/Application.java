package ca.uhn.fhir.jpa.starter;

import ca.uhn.fhir.context.FhirContext;
import ca.uhn.fhir.jpa.rp.r4.PersonResourceProvider;
import ca.uhn.fhir.jpa.rp.r4.PractitionerRoleResourceProvider;
import ca.uhn.fhir.jpa.starter.auth.PkbConsentService;
import ca.uhn.fhir.jpa.starter.auth.model.Actor;
import ca.uhn.fhir.jpa.starter.auth.model.Immunization;
import ca.uhn.fhir.jpa.starter.auth.model.Patient;
import ca.uhn.fhir.jpa.starter.auth.model.Team;
import ca.uhn.fhir.jpa.subscription.channel.config.SubscriptionChannelConfig;
import ca.uhn.fhir.jpa.subscription.match.config.SubscriptionProcessorConfig;
import ca.uhn.fhir.jpa.subscription.match.config.WebsocketDispatcherConfig;
import ca.uhn.fhir.jpa.subscription.submit.config.SubscriptionSubmitterConfig;
import ca.uhn.fhir.rest.client.api.IGenericClient;
import com.osohq.oso.Oso;
import org.apache.commons.io.IOUtils;
import org.hl7.fhir.r4.model.DomainResource;
import org.hl7.fhir.r4.model.IdType;
import org.hl7.fhir.r4.model.Person;
import org.keycloak.adapters.servlet.KeycloakOIDCFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
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
		
		registerSimple(oso, Actor.class);
		registerSimple(oso, Immunization.class);
		registerSimple(oso, Patient.class);
		registerSimple(oso, ca.uhn.fhir.jpa.starter.auth.model.Resource.class);
		registerSimple(oso, Team.class);
		oso.loadStr(IOUtils.toString(resource.getInputStream(), StandardCharsets.UTF_8), resource.getFilename());
		return oso;
	}

	private void registerSimple(Oso oso, Class<?> clazz) {
		oso.registerClass(clazz, clazz.getSimpleName());
	}

	@Bean
	@Qualifier("self")
	public IGenericClient selfClient(FhirContext context) {
		return context.newRestfulGenericClient("http://localhost:8080/fhir/");
	}
	
	@Bean
	public PkbConsentService pkbConsentService(Oso oso, @Qualifier("self") IGenericClient selfClient) {
		return new PkbConsentService(oso, selfClient);
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
		// TODO: MFA - Figure out how to bypass keycloak for self-access.
//		registration.addUrlPatterns("/fhir/*");
		registration.addUrlPatterns("/keycloak/*");
		registration.addInitParameter("keycloak.config.skipPattern", "/fhir/metadata");
		registration.setName("Keycloak Filter");
		return registration;
	}
}
