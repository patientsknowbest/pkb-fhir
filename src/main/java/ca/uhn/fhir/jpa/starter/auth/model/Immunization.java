package ca.uhn.fhir.jpa.starter.auth.model;

public class Immunization extends Resource {

	public Immunization(String id, Patient patient) {
		super(id, patient);
	}
}
