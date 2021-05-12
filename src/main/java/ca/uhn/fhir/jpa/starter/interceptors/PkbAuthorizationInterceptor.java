package ca.uhn.fhir.jpa.starter.interceptors;

import ca.uhn.fhir.rest.api.server.RequestDetails;
import ca.uhn.fhir.rest.server.interceptor.auth.AuthorizationInterceptor;
import ca.uhn.fhir.rest.server.interceptor.auth.IAuthRule;
import ca.uhn.fhir.rest.server.interceptor.auth.RuleBuilder;
import org.hl7.fhir.r4.model.IdType;
import org.keycloak.KeycloakSecurityContext;
import org.keycloak.representations.AccessToken;
import org.keycloak.representations.IDToken;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.lang.invoke.MethodHandles;
import java.util.List;

public class PkbAuthorizationInterceptor extends AuthorizationInterceptor {
	private static final Logger log = LoggerFactory.getLogger(MethodHandles.lookup().lookupClass());
	@Override
	public List<IAuthRule> buildRuleList(RequestDetails theRequestDetails) {
		KeycloakSecurityContext securityContext = (KeycloakSecurityContext)theRequestDetails.getUserData().get(KeycloakAccessTokenInterceptor.USER_DATA_KEY_KEYCLOAK_SECURITY_CONTEXT);
		AccessToken accessToken = securityContext.getToken();
		IDToken idToken = securityContext.getIdToken();
		log.info("{} is accessing!", accessToken.getGivenName());
//		log.info("{} is accessing!", idToken.getOtherClaims().get("personid"));
		IdType userIdPatientId = null;
		boolean userIsAdmin = true;
		
		// Can I make calls to _myself_ or another FHIR server to figure out team memberships? consents?
		
		// Figure out the rules and implement them. Probably need to have some link between keycloak and a FHIR resource
		// reprenting the User, then figure out the rest from there (consent, team memberships, etc, can all be 
		// represented in FHIR)
//		if ("Bearer dfw98h38r".equals(authHeader)) {
//			// This user has access only to Patient/1 resources
//			userIdPatientId = new IdType("Patient", 1L);
//		} else if ("Bearer 39ff939jgg".equals(authHeader)) {
//			// This user has access to everything
//			userIsAdmin = true;
//		} else {
//			// Throw an HTTP 401
//			throw new AuthenticationException("Missing or invalid Authorization header value");
//		}

		// If the user is a specific patient, we create the following rule chain:
		// Allow the user to read anything in their own patient compartment
		// Allow the user to write anything in their own patient compartment
		// If a client request doesn't pass either of the above, deny it
		if (userIdPatientId != null) {
			return new RuleBuilder()
				.allow().read().allResources().inCompartment("Patient", userIdPatientId).andThen()
				.allow().write().allResources().inCompartment("Patient", userIdPatientId).andThen()
				.denyAll()
				.build();
		}

		// If the user is an admin, allow everything
		if (userIsAdmin) {
			return new RuleBuilder()
				.allowAll()
				.build();
		}

		// By default, deny everything. This should never get hit, but it's 
		// good to be defensive
		return new RuleBuilder()
			.denyAll()
			.build();
	}
}
