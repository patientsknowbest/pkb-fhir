package ca.uhn.fhir.jpa.starter.auth.model;

public class Resource {
	public String id;
	// TODO: MFA - This may be too simplistic. Not every resource has a patient.
	public Patient patient;

	public Resource(String id, Patient patient) {
		this.id = id;
		this.patient = patient;
	}
}
