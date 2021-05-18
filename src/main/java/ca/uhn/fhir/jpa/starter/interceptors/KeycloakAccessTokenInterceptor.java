package ca.uhn.fhir.jpa.starter.interceptors;

import ca.uhn.fhir.rest.api.server.RequestDetails;
import ca.uhn.fhir.rest.server.exceptions.AuthenticationException;
import ca.uhn.fhir.rest.server.interceptor.InterceptorAdapter;
import org.keycloak.KeycloakPrincipal;
import org.keycloak.KeycloakSecurityContext;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.security.Principal;

public class KeycloakAccessTokenInterceptor extends InterceptorAdapter {
	static final String USER_DATA_KEY_KEYCLOAK_SECURITY_CONTEXT = "ACCESS_TOKEN";

	@Override
	public boolean incomingRequestPostProcessed(RequestDetails theRequestDetails, HttpServletRequest theRequest, HttpServletResponse theResponse) throws AuthenticationException {
		Principal principal = theRequest.getUserPrincipal();
		if (principal != null) {
			if (principal instanceof KeycloakPrincipal) {
				KeycloakPrincipal keycloakPrincipal = (KeycloakPrincipal) principal;
				KeycloakSecurityContext session = keycloakPrincipal.getKeycloakSecurityContext();
				theRequestDetails.getUserData().put(USER_DATA_KEY_KEYCLOAK_SECURITY_CONTEXT, session);
			} else {
				throw new AuthenticationException("Principal is not a KeycloakPrincipal " + principal.getClass().getName());
			}
		}
		return true;
	}
}
