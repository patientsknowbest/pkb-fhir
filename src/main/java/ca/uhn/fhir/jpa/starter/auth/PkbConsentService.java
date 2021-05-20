package ca.uhn.fhir.jpa.starter.auth;

import ca.uhn.fhir.jpa.rp.r4.PersonResourceProvider;
import ca.uhn.fhir.jpa.rp.r4.PractitionerRoleResourceProvider;
import ca.uhn.fhir.jpa.starter.auth.model.Actor;
import ca.uhn.fhir.jpa.starter.auth.model.Immunization;
import ca.uhn.fhir.jpa.starter.auth.model.Patient;
import ca.uhn.fhir.jpa.starter.auth.model.Team;
import ca.uhn.fhir.model.api.Include;
import ca.uhn.fhir.rest.api.RestOperationTypeEnum;
import ca.uhn.fhir.rest.api.server.RequestDetails;
import ca.uhn.fhir.rest.client.api.IGenericClient;
import ca.uhn.fhir.rest.server.interceptor.consent.ConsentOutcome;
import ca.uhn.fhir.rest.server.interceptor.consent.IConsentContextServices;
import ca.uhn.fhir.rest.server.interceptor.consent.IConsentService;
import com.osohq.oso.Oso;
import org.hl7.fhir.instance.model.api.IBaseResource;
import org.hl7.fhir.r4.model.Bundle;
import org.hl7.fhir.r4.model.GraphDefinition;
import org.hl7.fhir.r4.model.IdType;
import org.hl7.fhir.r4.model.Parameters;
import org.hl7.fhir.r4.model.Person;
import org.hl7.fhir.r4.model.Practitioner;
import org.hl7.fhir.r4.utils.GraphQLEngine;
import org.keycloak.KeycloakSecurityContext;
import org.keycloak.representations.AccessToken;
import org.keycloak.representations.JsonWebToken;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

public class PkbConsentService implements IConsentService {
	private final Oso oso;
	private IGenericClient selfClient;

	public PkbConsentService(Oso oso, IGenericClient selfClient) {
		this.oso = oso;
		this.selfClient = selfClient;
	}

	/**
	 * Read any data we absolutlely know we will need in advance to authorize the request
	 * @param theRequestDetails
	 * @param theContextServices
	 * @return
	 */
	@Override
	public ConsentOutcome startOperation(RequestDetails theRequestDetails, IConsentContextServices theContextServices) {
		// TODO: MFA - Short circuit public resources
		// TODO: MFA - Short circuit endpoints which we can fully authorize upfront (i.e. no resource attributes in policy)
		// TODO: MFA - Short circuit search operations where we're able to apply mandatory additional filters.
		if (theRequestDetails.getRequestPath().equals("metadata")) {
			return ConsentOutcome.AUTHORIZED;
		}
		return ConsentOutcome.PROCEED;
	}

//	private Optional<AccessToken> getAccessToken(RequestDetails theRequestDetails) {
//		return Optional.ofNullable((KeycloakSecurityContext) theRequestDetails.getUserData().get(KeycloakAccessTokenInterceptor.USER_DATA_KEY_KEYCLOAK_SECURITY_CONTEXT))
//			.map(KeycloakSecurityContext::getToken);
//	}

	@Override
	public ConsentOutcome canSeeResource(RequestDetails theRequestDetails, IBaseResource theResource, IConsentContextServices theContextServices) {
		var restOperationType = theRequestDetails.getRestOperationType();
		
//		return getAccessToken(theRequestDetails)
//			.map(JsonWebToken::getOtherClaims)
//			.flatMap(otherClaims -> Optional.ofNullable((String) otherClaims.get("personId")))
		return Optional.of("11502")
			.flatMap(personIdStr -> {
//				var parameters = new Parameters();
//				parameters.addParameter("graph", "authz");
//				var result = selfClient.operation()
//					.onInstance(new IdType(new org.hl7.fhir.r4.model.Person().fhirType(), personIdStr))
//					.named("$graph")
//					.withParameters(parameters)
//					.useHttpGet().execute()
//					.getParameter("result");
				// TODO: MFA - Efficiently pull all the FHIR object graph that we need for authorization
				// TODO: MFA - Probably this needs some serious caching to be even slightly efficient.
				return Optional.ofNullable(new Person());
			})
			.map(person -> oso.isAllowed(map(person), map(restOperationType), map(theResource)))
			.filter(allowed -> allowed)
			.map(allowed -> ConsentOutcome.PROCEED)
			.orElse(ConsentOutcome.REJECT);
	}

	@Override
	public ConsentOutcome willSeeResource(RequestDetails theRequestDetails, IBaseResource theResource, IConsentContextServices theContextServices) {
		return ConsentOutcome.PROCEED;
	}

	/**
	 * Mapping to specialized types for authorization.
	 * 
	 * These are plain structures with public fields for Oso to use. This makes policy writing easier, and also allows
	 * partial evaluation to work.
	 */
	private Object map(RestOperationTypeEnum restOperationTypeEnum) {
		return restOperationTypeEnum.getCode();
	}
	
	private Object map(IBaseResource baseResource) {
		if (baseResource instanceof org.hl7.fhir.r4.model.Immunization) {
			var imm = (org.hl7.fhir.r4.model.Immunization)baseResource;
			return new Immunization(imm.getId(), (Patient)map(imm.getPatientTarget()));
		} else if (baseResource instanceof org.hl7.fhir.r4.model.Patient) {
			var pat = (org.hl7.fhir.r4.model.Patient) baseResource;
			return new Patient(pat.getId(), false); // TODO: MFA - Access frozen?
		} else {
			throw new UnsupportedOperationException("Type " + baseResource.getClass() + " not yet mapped for authorization");
		}
	}
	
	private Object map(org.hl7.fhir.r4.model.Person person) {
		// Get any orgs for any practitioner, practically this means 
		// Person -> link -> Practitioner -> PractitionerRole -> Organization
//		List<Team> teams = person.getLink().stream()
//			.map(Person.PersonLinkComponent::getTargetTarget)
//			.filter(ref -> ref instanceof Practitioner).map(Practitioner.class::cast)
//			// TODO: MFA - this is hideously inefficient
//			.filter(practitioner -> practitionerRoleResourceProvider.search());
//		
//		List<Patient> patients = person.getLink().stream().map(Person.PersonLinkComponent::getTargetTarget)
//				.filter(ref -> ref instanceof org.hl7.fhir.r4.model.Patient).map(Patient.class::cast)
//				.map(pat -> new Patient(false)) // TODO: MFA - Access frozen in FHIR model?
//				.collect(Collectors.toList());
//		return new Actor(true, 	// TODO: MFA - System users
//			!teams.isEmpty(),
//			teams,
//			false, 					// TODO: MFA - check header
//			false, 				// TODO: MFA - Does FHIR have any concept of this?
//			patients);
		return new Actor(true, 	// TODO: MFA - System users
			false,
			new ArrayList<>(),
			false, 					// TODO: MFA - check header
			false, 				// TODO: MFA - Does FHIR have any concept of this?
			new Patient("59", false));
	}
}
