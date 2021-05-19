create user fhir password 'fhir';
create user keycloak password 'keycloak';

create database fhir with owner fhir; 
create database keycloak with owner keycloak; 