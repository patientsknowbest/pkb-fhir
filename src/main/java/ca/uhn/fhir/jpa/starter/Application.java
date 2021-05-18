package ca.uhn.fhir.jpa.starter;

import ca.uhn.fhir.jpa.starter.interceptors.PkbConsentService;
import ca.uhn.fhir.jpa.subscription.channel.config.SubscriptionChannelConfig;
import ca.uhn.fhir.jpa.subscription.match.config.SubscriptionProcessorConfig;
import ca.uhn.fhir.jpa.subscription.match.config.WebsocketDispatcherConfig;
import ca.uhn.fhir.jpa.subscription.submit.config.SubscriptionSubmitterConfig;
import org.keycloak.adapters.servlet.KeycloakOIDCFilter;
import org.springframework.beans.factory.annotation.Autowired;
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
	public PkbConsentService pkbConsentService() {
		return new PkbConsentService();
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
