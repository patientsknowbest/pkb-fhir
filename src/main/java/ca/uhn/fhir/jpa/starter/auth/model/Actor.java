package ca.uhn.fhir.jpa.starter.auth.model;

import java.util.List;

public class Actor {
	// Might be a system user otherwise.
	public boolean isPerson;
	
	public boolean isAccessFrozen;
	
	public boolean isTeamPro;
	
	// Only relevant if isTeamPro
	public List<Team> teams;

	// The user's patient personas.
	public Patient patient;
	
	// Session information
	public boolean isBtgActive;
	
	public Actor(boolean isPerson, boolean isTeamPro, List<Team> teams, boolean isBtgActive, boolean isAccessFrozen, Patient patient) {
		this.isPerson = isPerson;
		this.isTeamPro = isTeamPro;
		this.teams = teams;
		this.isBtgActive = isBtgActive;
		this.isAccessFrozen = isAccessFrozen;
		this.patient = patient;
	}
}
