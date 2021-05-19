allow(person: Person, "search-type", immunization: Immunization) if
    # Can't use property access syntax on private props 
    person.getId() = "Person/11502/_history/1" and 
        immunization.getId() = "Immunization/100/_history/1";