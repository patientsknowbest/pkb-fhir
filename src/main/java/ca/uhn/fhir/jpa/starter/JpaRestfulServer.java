package ca.uhn.fhir.jpa.starter;

import ca.uhn.fhir.jpa.starter.auth.KeycloakAccessTokenInterceptor;
import ca.uhn.fhir.jpa.starter.auth.PkbConsentService;
import ca.uhn.fhir.rest.server.interceptor.consent.ConsentInterceptor;
import org.springframework.context.annotation.Import;

import javax.servlet.ServletException;

@Import(AppProperties.class)
public class JpaRestfulServer extends BaseJpaRestfulServer {

	private static final long serialVersionUID = 1L;
	private PkbConsentService pkbConsentService;

	public JpaRestfulServer(PkbConsentService pkbConsentService) {
		super();
		this.pkbConsentService = pkbConsentService;
	}

	@Override
	protected void initialize() throws ServletException {
		super.initialize();
		registerInterceptor(new KeycloakAccessTokenInterceptor());
		registerInterceptor(new ConsentInterceptor(pkbConsentService));
	}

}
