allow(person: Person, "search-type", immunization: Immunization) if 
    person.id.value = 11502 and 
        immunization.id.value = 100;