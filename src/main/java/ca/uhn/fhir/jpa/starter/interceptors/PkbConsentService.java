package ca.uhn.fhir.jpa.starter.interceptors;

import ca.uhn.fhir.jpa.rp.r4.PersonResourceProvider;
import ca.uhn.fhir.rest.api.server.RequestDetails;
import ca.uhn.fhir.rest.server.interceptor.consent.ConsentOutcome;
import ca.uhn.fhir.rest.server.interceptor.consent.IConsentContextServices;
import ca.uhn.fhir.rest.server.interceptor.consent.IConsentService;
import org.hl7.fhir.instance.model.api.IBaseResource;
import org.hl7.fhir.r4.model.IdType;
import org.hl7.fhir.r4.model.Person;
import org.keycloak.KeycloakSecurityContext;
import org.keycloak.representations.AccessToken;

public class PkbConsentService implements IConsentService {

	private PersonResourceProvider personResourceProvider;

	public PkbConsentService(PersonResourceProvider personResourceProvider) {
		this.personResourceProvider = personResourceProvider;
	}

	/**
	 * Read any data we absolutlely know we will need in advance to authorize the request
	 * @param theRequestDetails
	 * @param theContextServices
	 * @return
	 */
	@Override
	public ConsentOutcome startOperation(RequestDetails theRequestDetails, IConsentContextServices theContextServices) {
		if (theRequestDetails.getRequestPath().equals("metadata")) {
			return ConsentOutcome.AUTHORIZED;
		}
		
		KeycloakSecurityContext ksc = (KeycloakSecurityContext)theRequestDetails.getUserData().get(KeycloakAccessTokenInterceptor.USER_DATA_KEY_KEYCLOAK_SECURITY_CONTEXT);
		AccessToken accessToken = null;
		if (ksc != null) {
			accessToken = ksc.getToken();
		}

		if (accessToken == null) {
			return ConsentOutcome.REJECT;
		}
//		 TODO: MFA - Non-person users.
		String actorPersonId = (String) accessToken.getOtherClaims().get("personId");
		if (actorPersonId != null) {
			Person read = personResourceProvider.read(null, new IdType(actorPersonId), null);
			theRequestDetails.getUserData().put("person", read);
		}
		return ConsentOutcome.PROCEED;
	}

	@Override
	public ConsentOutcome canSeeResource(RequestDetails theRequestDetails, IBaseResource theResource, IConsentContextServices theContextServices) {
		// Apply the filter.
		Person actor = (Person)theRequestDetails.getUserData().get("person");
		// 
		return ConsentOutcome.PROCEED;
	}

	@Override
	public ConsentOutcome willSeeResource(RequestDetails theRequestDetails, IBaseResource theResource, IConsentContextServices theContextServices) {
		return ConsentOutcome.PROCEED;
	}
}
