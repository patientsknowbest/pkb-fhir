package ca.uhn.fhir.jpa.starter.auth.model;

public class Patient extends Resource {
	public boolean isAccessFrozen;

	public Patient(String id, boolean isAccessFrozen) {
		super(id, null);
		this.patient = this; // Weird I know.
		this.isAccessFrozen = isAccessFrozen;
	}
}
