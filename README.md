# PKB-FHIR

Forked from https://github.com/hapifhir/hapi-fhir-jpaserver-starter

This project is a proof of concept to show how PKB can use a standard FHIR server with minimal customization for 
applying access control rules.

Modifications from the original include:
- running on postgres
- running keycloak server alongside the fhir application
- running nginx reverse proxy
- a simple SPA which triggers login using keycloak.js
- applying keycloak's servlet filter to the FHIR application

To run: 
Add a local DNS entry for fakepkb.local pointing to 127.0.0.1 e.g. by editing /etc/hosts.
This is a byproduct of https://issues.redhat.com/browse/KEYCLOAK-2623.

Build and run the application by running `docker-compose up`

Access the frontend application at http://fakepkb.local/
Username 'martin' password 'P@55word' is set up for testing.

Access the keycloak admin UI at http://fakepkb.local/auth
Username 'admin' password 'admin' is set up for testing.

# TODO
implement authorization rules using FHIR interceptors:

- https://hapifhir.io/hapi-fhir/docs/security/authorization_interceptor.html
- https://hapifhir.io/hapi-fhir/docs/security/consent_interceptor.html
- https://hapifhir.io/hapi-fhir/docs/security/search_narrowing_interceptor.html

implement audit trail / access log

- https://hapifhir.io/hapi-fhir/docs/security/consent_interceptor.html

deploy to sample production-like environment

- terraform configuration

integrate with existing PKB stack

- ????