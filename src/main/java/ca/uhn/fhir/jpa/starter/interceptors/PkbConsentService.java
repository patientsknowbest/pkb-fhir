package ca.uhn.fhir.jpa.starter.interceptors;

import ca.uhn.fhir.rest.api.server.RequestDetails;
import ca.uhn.fhir.rest.server.interceptor.consent.ConsentOutcome;
import ca.uhn.fhir.rest.server.interceptor.consent.IConsentContextServices;
import ca.uhn.fhir.rest.server.interceptor.consent.IConsentService;
import org.hl7.fhir.instance.model.api.IBaseResource;

public class PkbConsentService implements IConsentService {
	@Override
	public ConsentOutcome startOperation(RequestDetails theRequestDetails, IConsentContextServices theContextServices) {
		return ConsentOutcome.PROCEED;
	}

	@Override
	public ConsentOutcome canSeeResource(RequestDetails theRequestDetails, IBaseResource theResource, IConsentContextServices theContextServices) {
		return ConsentOutcome.PROCEED;
	}
}
