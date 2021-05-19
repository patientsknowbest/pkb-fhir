allow(person: Person, "search-type", immunization: Immunization) if
    # Can't use property access syntax on private props 
    person.getId() = "11502" and 
        immunization.getId() = "100";