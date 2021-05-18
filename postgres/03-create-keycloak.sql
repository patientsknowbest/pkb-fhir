--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2 (Debian 13.2-1.pgdg100+1)
-- Dumped by pg_dump version 13.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO keycloak;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO keycloak;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO keycloak;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO keycloak;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO keycloak;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO keycloak;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO keycloak;

--
-- Name: client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO keycloak;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_attributes OWNER TO keycloak;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO keycloak;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO keycloak;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO keycloak;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO keycloak;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO keycloak;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO keycloak;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO keycloak;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO keycloak;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO keycloak;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO keycloak;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO keycloak;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO keycloak;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO keycloak;

--
-- Name: component; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO keycloak;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE public.component_config OWNER TO keycloak;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO keycloak;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO keycloak;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO keycloak;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO keycloak;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO keycloak;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


ALTER TABLE public.event_entity OWNER TO keycloak;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO keycloak;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO keycloak;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO keycloak;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO keycloak;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO keycloak;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO keycloak;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO keycloak;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO keycloak;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO keycloak;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO keycloak;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO keycloak;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO keycloak;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO keycloak;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO keycloak;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO keycloak;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO keycloak;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO keycloak;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO keycloak;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO keycloak;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO keycloak;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO keycloak;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO keycloak;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO keycloak;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO keycloak;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO keycloak;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO keycloak;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO keycloak;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO keycloak;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO keycloak;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO keycloak;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO keycloak;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO keycloak;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO keycloak;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO keycloak;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO keycloak;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO keycloak;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO keycloak;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO keycloak;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO keycloak;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO keycloak;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO keycloak;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO keycloak;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO keycloak;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO keycloak;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO keycloak;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO keycloak;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO keycloak;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO keycloak;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO keycloak;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO keycloak;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO keycloak;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO keycloak;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO keycloak;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO keycloak;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO keycloak;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO keycloak;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO keycloak;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO keycloak;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO keycloak;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO keycloak;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO keycloak;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO keycloak;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
17c2f855-4124-4a71-9a5a-1fb24e45d614	\N	auth-cookie	master	e6d64ede-1a4b-4802-bd65-2cb3b5d068b2	2	10	f	\N	\N
8a22c178-60a4-4554-9f08-152694decb66	\N	auth-spnego	master	e6d64ede-1a4b-4802-bd65-2cb3b5d068b2	3	20	f	\N	\N
27276d75-dc2b-40c1-a742-ebf03aff6074	\N	identity-provider-redirector	master	e6d64ede-1a4b-4802-bd65-2cb3b5d068b2	2	25	f	\N	\N
db1121a2-324e-4c61-9f18-205a0954c55d	\N	\N	master	e6d64ede-1a4b-4802-bd65-2cb3b5d068b2	2	30	t	0f3b5def-dbd0-40d9-a454-c7b0c2f192ac	\N
8a3ccf24-0634-4472-b68b-570517f15735	\N	auth-username-password-form	master	0f3b5def-dbd0-40d9-a454-c7b0c2f192ac	0	10	f	\N	\N
7b0e39ed-3afd-47c1-9299-41287d596141	\N	\N	master	0f3b5def-dbd0-40d9-a454-c7b0c2f192ac	1	20	t	4dd6498a-c197-49ec-9dfb-94bb760b380c	\N
f3f25c21-f499-41f4-9e18-a6bfa982cbec	\N	conditional-user-configured	master	4dd6498a-c197-49ec-9dfb-94bb760b380c	0	10	f	\N	\N
eac878a2-1b03-4054-9ccd-e09e3a0b6a50	\N	auth-otp-form	master	4dd6498a-c197-49ec-9dfb-94bb760b380c	0	20	f	\N	\N
8db4ca0d-598d-4172-85b4-b740266ed29d	\N	direct-grant-validate-username	master	07a0ce42-da16-45fb-ae96-9964fca76605	0	10	f	\N	\N
fbc728a3-70c6-4945-a957-48052a8880d2	\N	direct-grant-validate-password	master	07a0ce42-da16-45fb-ae96-9964fca76605	0	20	f	\N	\N
d9a3dd72-5b20-4289-9bc9-d2280e0178b1	\N	\N	master	07a0ce42-da16-45fb-ae96-9964fca76605	1	30	t	7bddf36a-212d-49ee-b7d3-bf915b133caa	\N
6ac32896-ae26-4a0a-86dd-42166e409bbe	\N	conditional-user-configured	master	7bddf36a-212d-49ee-b7d3-bf915b133caa	0	10	f	\N	\N
a7166f16-321e-464d-a4fd-dbcc65c0f99f	\N	direct-grant-validate-otp	master	7bddf36a-212d-49ee-b7d3-bf915b133caa	0	20	f	\N	\N
61df3ec5-e16d-46ba-8903-a3b2a028a4ea	\N	registration-page-form	master	a4d154e3-b19b-4635-b8ba-a3b04a74b2d1	0	10	t	2928f7f6-5d95-47f7-a6be-052408853932	\N
1056b8bb-b4ba-442a-8129-3cda9fba09de	\N	registration-user-creation	master	2928f7f6-5d95-47f7-a6be-052408853932	0	20	f	\N	\N
5925ada6-27e7-4375-8ee8-d878ec9e781f	\N	registration-profile-action	master	2928f7f6-5d95-47f7-a6be-052408853932	0	40	f	\N	\N
f7188658-ecff-4a71-8aea-553956d3df44	\N	registration-password-action	master	2928f7f6-5d95-47f7-a6be-052408853932	0	50	f	\N	\N
aefbd747-49d4-4b16-b819-be6203488623	\N	registration-recaptcha-action	master	2928f7f6-5d95-47f7-a6be-052408853932	3	60	f	\N	\N
4e9dad46-5566-48f2-94cc-d6425d64c54e	\N	reset-credentials-choose-user	master	a714b25d-bf21-4195-89b2-2e0a24de196c	0	10	f	\N	\N
25cf0ca0-60f3-4b56-9f36-edd425073aaa	\N	reset-credential-email	master	a714b25d-bf21-4195-89b2-2e0a24de196c	0	20	f	\N	\N
ba4b3a49-7a49-4330-a0ee-696bb3b0bc8c	\N	reset-password	master	a714b25d-bf21-4195-89b2-2e0a24de196c	0	30	f	\N	\N
7901fda1-a27d-4b7c-9dad-9b0faefe55a4	\N	\N	master	a714b25d-bf21-4195-89b2-2e0a24de196c	1	40	t	2f2896f9-c7a5-4196-ba89-42e29dfb13a2	\N
b6435d22-bdf0-45e7-a649-d3a059765830	\N	conditional-user-configured	master	2f2896f9-c7a5-4196-ba89-42e29dfb13a2	0	10	f	\N	\N
2a7463f6-6841-4e62-9754-b8894f2f8e35	\N	reset-otp	master	2f2896f9-c7a5-4196-ba89-42e29dfb13a2	0	20	f	\N	\N
af544568-43b2-4659-bbbb-119cd88a7cef	\N	client-secret	master	40a1b354-9df0-4907-b6e2-90d10774663e	2	10	f	\N	\N
49b20d54-0f07-49cd-a2b6-896e8f314c88	\N	client-jwt	master	40a1b354-9df0-4907-b6e2-90d10774663e	2	20	f	\N	\N
eb22ab30-aa3d-4c16-87c9-503d6890eedc	\N	client-secret-jwt	master	40a1b354-9df0-4907-b6e2-90d10774663e	2	30	f	\N	\N
3f206652-310f-447a-ae2e-8317a88f1888	\N	client-x509	master	40a1b354-9df0-4907-b6e2-90d10774663e	2	40	f	\N	\N
e3e55699-12cc-45ae-97ad-3d2e57681331	\N	idp-review-profile	master	f957dd9c-c56c-4343-a5fa-7e96aa063408	0	10	f	\N	f0439edf-d491-43d9-b399-14d5464b5866
69837c5e-8adb-408a-b0e1-801d2d0749ff	\N	\N	master	f957dd9c-c56c-4343-a5fa-7e96aa063408	0	20	t	11fe21e9-8a0b-4559-b0a6-c9f217e7ad01	\N
9bb1a792-59c0-4165-9879-95302101531c	\N	idp-create-user-if-unique	master	11fe21e9-8a0b-4559-b0a6-c9f217e7ad01	2	10	f	\N	77996143-1ede-4e0c-89f1-1f64659dd5bc
d367abed-064d-45db-8bad-4540e45e0a2c	\N	\N	master	11fe21e9-8a0b-4559-b0a6-c9f217e7ad01	2	20	t	c6b5431b-e73d-4ee3-8726-1b7a67e90332	\N
590880e8-6cc5-493f-be3f-0ed99f01a57b	\N	idp-confirm-link	master	c6b5431b-e73d-4ee3-8726-1b7a67e90332	0	10	f	\N	\N
5bbcd233-3412-48c5-aee2-624a221bc0c6	\N	\N	master	c6b5431b-e73d-4ee3-8726-1b7a67e90332	0	20	t	5f91bf93-3ff3-40ee-a3f2-9729b3b1f008	\N
631cf2ff-6a6a-417d-9d0c-c6d75511c8a1	\N	idp-email-verification	master	5f91bf93-3ff3-40ee-a3f2-9729b3b1f008	2	10	f	\N	\N
141b1610-1588-483b-b478-3189c5ec4593	\N	\N	master	5f91bf93-3ff3-40ee-a3f2-9729b3b1f008	2	20	t	c2ce910f-38f0-4cce-8ca0-1e4c2507cb6f	\N
c0e240a0-1d5d-4dd0-9468-29ea20f356ba	\N	idp-username-password-form	master	c2ce910f-38f0-4cce-8ca0-1e4c2507cb6f	0	10	f	\N	\N
ef0e046b-877a-43a4-9521-ba3fde7eee15	\N	\N	master	c2ce910f-38f0-4cce-8ca0-1e4c2507cb6f	1	20	t	ff10737f-ee94-41b7-8f73-4ed7e54d1da8	\N
dae87334-9418-4499-84d4-51eee7458e43	\N	conditional-user-configured	master	ff10737f-ee94-41b7-8f73-4ed7e54d1da8	0	10	f	\N	\N
b4ec044c-8980-41bb-a2cb-d012a37c04bc	\N	auth-otp-form	master	ff10737f-ee94-41b7-8f73-4ed7e54d1da8	0	20	f	\N	\N
7c82fb17-a845-47f4-8d32-03a1d389cf5b	\N	http-basic-authenticator	master	867bb7cb-db8b-43dc-8d8a-661f5b7e7023	0	10	f	\N	\N
c0e144ab-5aab-4f66-a726-743656c5ff93	\N	docker-http-basic-authenticator	master	ef33e11d-e7fe-47f7-a760-ab561aea2c4e	0	10	f	\N	\N
5708b01b-bcfc-4eed-9de6-697270e7de2b	\N	no-cookie-redirect	master	6d95f7ba-d5e9-4b25-9461-e7e6b2b38708	0	10	f	\N	\N
5493be9f-b54c-4eba-8ad1-91fffd7839ab	\N	\N	master	6d95f7ba-d5e9-4b25-9461-e7e6b2b38708	0	20	t	855ae211-f592-4071-8300-023b04ad52e4	\N
ab4b9e79-f1f7-4a96-a1b0-d342be8e874e	\N	basic-auth	master	855ae211-f592-4071-8300-023b04ad52e4	0	10	f	\N	\N
260aa8f1-0a66-4022-8582-15a3b12f3b5f	\N	basic-auth-otp	master	855ae211-f592-4071-8300-023b04ad52e4	3	20	f	\N	\N
a01cc7cf-cb05-4422-8549-df120ec7850f	\N	auth-spnego	master	855ae211-f592-4071-8300-023b04ad52e4	3	30	f	\N	\N
75809be8-0260-440b-8736-7d97794f76d2	\N	auth-cookie	pkb-fhir	8adafb64-f5a8-424e-b79e-0f6646c6d6d0	2	10	f	\N	\N
8c2455f5-7101-4103-ac39-94e0fd2ec6aa	\N	auth-spnego	pkb-fhir	8adafb64-f5a8-424e-b79e-0f6646c6d6d0	3	20	f	\N	\N
537f4d11-ee54-4470-8ae5-c59bd57a4525	\N	identity-provider-redirector	pkb-fhir	8adafb64-f5a8-424e-b79e-0f6646c6d6d0	2	25	f	\N	\N
2ff0d218-50e3-4846-8dbb-3a1a21bd59a1	\N	\N	pkb-fhir	8adafb64-f5a8-424e-b79e-0f6646c6d6d0	2	30	t	30045454-5f32-4ace-a8bb-e28b0c5f7fe1	\N
d215b383-31af-402e-8061-456eca9a0069	\N	auth-username-password-form	pkb-fhir	30045454-5f32-4ace-a8bb-e28b0c5f7fe1	0	10	f	\N	\N
a4721d34-d80e-4291-a8cb-8cbdcc0e6606	\N	\N	pkb-fhir	30045454-5f32-4ace-a8bb-e28b0c5f7fe1	1	20	t	a28f4933-4d6e-4b21-ba87-9892c08f8d2e	\N
787106f2-dee5-4736-884c-e41e14597895	\N	conditional-user-configured	pkb-fhir	a28f4933-4d6e-4b21-ba87-9892c08f8d2e	0	10	f	\N	\N
0327ea76-3e14-47ad-a14c-5b7313e1b6f5	\N	auth-otp-form	pkb-fhir	a28f4933-4d6e-4b21-ba87-9892c08f8d2e	0	20	f	\N	\N
7e21b74d-90ad-4bb3-86fb-fd07dbb00826	\N	direct-grant-validate-username	pkb-fhir	16636059-937d-4ab2-90f8-c4ff5f1eec9f	0	10	f	\N	\N
418eff83-25de-459d-bc78-591051620b8f	\N	direct-grant-validate-password	pkb-fhir	16636059-937d-4ab2-90f8-c4ff5f1eec9f	0	20	f	\N	\N
074ecbfe-46fa-4d2a-a358-3ac992590165	\N	\N	pkb-fhir	16636059-937d-4ab2-90f8-c4ff5f1eec9f	1	30	t	47868bd0-5b1f-4aa0-a294-59ad2d1ed464	\N
f9a77fa2-dbe3-419d-892d-df8f712b24bc	\N	conditional-user-configured	pkb-fhir	47868bd0-5b1f-4aa0-a294-59ad2d1ed464	0	10	f	\N	\N
cac2acc0-f3f7-4044-9e2f-4410498c562e	\N	direct-grant-validate-otp	pkb-fhir	47868bd0-5b1f-4aa0-a294-59ad2d1ed464	0	20	f	\N	\N
ea6b6e5b-3ee6-46ad-9458-0cbef4cc6d8d	\N	registration-page-form	pkb-fhir	cf258020-dd88-4266-9e1c-fabaa0596805	0	10	t	d73efc3b-6855-47a9-99a5-0c869484c375	\N
21ade561-b724-4cde-9735-54dfc0ea786a	\N	registration-user-creation	pkb-fhir	d73efc3b-6855-47a9-99a5-0c869484c375	0	20	f	\N	\N
5fa53254-c101-4166-87ef-882d01c9dc90	\N	registration-profile-action	pkb-fhir	d73efc3b-6855-47a9-99a5-0c869484c375	0	40	f	\N	\N
76b8c65d-6714-42c2-b9bd-9d5f5e38bc16	\N	registration-password-action	pkb-fhir	d73efc3b-6855-47a9-99a5-0c869484c375	0	50	f	\N	\N
ff088f17-df05-4972-b8ca-9f8f6aedf386	\N	registration-recaptcha-action	pkb-fhir	d73efc3b-6855-47a9-99a5-0c869484c375	3	60	f	\N	\N
79772c6c-acf5-491a-992f-794d1dee0faf	\N	reset-credentials-choose-user	pkb-fhir	d6fa4daf-3120-4007-a377-36d4841d3eff	0	10	f	\N	\N
42774d21-c5d0-4d03-a56e-05c155719c5b	\N	reset-credential-email	pkb-fhir	d6fa4daf-3120-4007-a377-36d4841d3eff	0	20	f	\N	\N
e705b7a5-41a5-4606-99b1-3640577f47d5	\N	reset-password	pkb-fhir	d6fa4daf-3120-4007-a377-36d4841d3eff	0	30	f	\N	\N
550903f8-590e-43dc-b2ea-075bacfa28bf	\N	\N	pkb-fhir	d6fa4daf-3120-4007-a377-36d4841d3eff	1	40	t	1616b88a-81d9-443e-9a91-127a94988203	\N
6565f908-b424-4c85-979d-2e2480623c91	\N	conditional-user-configured	pkb-fhir	1616b88a-81d9-443e-9a91-127a94988203	0	10	f	\N	\N
564f8def-8ce2-4ab9-9109-ca8bcca3f03f	\N	reset-otp	pkb-fhir	1616b88a-81d9-443e-9a91-127a94988203	0	20	f	\N	\N
7cce25d0-c045-47c3-9b11-defafff1ab01	\N	client-secret	pkb-fhir	60d9901a-81dd-4701-87b7-2338e93e2dfe	2	10	f	\N	\N
8c6c74d2-bd47-4e25-bd63-949199f7eb9c	\N	client-jwt	pkb-fhir	60d9901a-81dd-4701-87b7-2338e93e2dfe	2	20	f	\N	\N
a3a853bd-1c2b-43a4-9138-a5038da8d2f2	\N	client-secret-jwt	pkb-fhir	60d9901a-81dd-4701-87b7-2338e93e2dfe	2	30	f	\N	\N
6fb1132d-be45-4df5-b005-4f3b103dcddc	\N	client-x509	pkb-fhir	60d9901a-81dd-4701-87b7-2338e93e2dfe	2	40	f	\N	\N
1192a1e8-ba85-4597-954d-bd4f5fc82a8a	\N	idp-review-profile	pkb-fhir	0639f17b-ab0d-4791-bb0a-c38be03f435e	0	10	f	\N	44a4a267-308e-4124-8d0a-d6a5939bb054
0ff2bafd-d1bd-49fa-a630-b1eab800d49f	\N	\N	pkb-fhir	0639f17b-ab0d-4791-bb0a-c38be03f435e	0	20	t	941c7b62-1fc7-4fd6-a77b-c85418484a36	\N
e3afd7af-8e52-4acd-939e-a752b0a54b67	\N	idp-create-user-if-unique	pkb-fhir	941c7b62-1fc7-4fd6-a77b-c85418484a36	2	10	f	\N	911a23e6-dde5-4482-8a16-70ec63e7f05c
0d6d9d91-cedf-49e2-b2e5-e0d43d465f41	\N	\N	pkb-fhir	941c7b62-1fc7-4fd6-a77b-c85418484a36	2	20	t	0c2772e5-1046-48ab-b16c-907e5bafe19d	\N
dd10a08d-1c83-4e44-91e3-dac88edf94b4	\N	idp-confirm-link	pkb-fhir	0c2772e5-1046-48ab-b16c-907e5bafe19d	0	10	f	\N	\N
bb36622d-e360-45f6-8a09-094b70815cae	\N	\N	pkb-fhir	0c2772e5-1046-48ab-b16c-907e5bafe19d	0	20	t	410ed43c-d11b-44a6-886e-5a7714cb6255	\N
4c258877-5d1a-4309-b4c3-092260bdb881	\N	idp-email-verification	pkb-fhir	410ed43c-d11b-44a6-886e-5a7714cb6255	2	10	f	\N	\N
0f809f0c-9882-4723-a8bd-32a8c44d4663	\N	\N	pkb-fhir	410ed43c-d11b-44a6-886e-5a7714cb6255	2	20	t	6a730924-0352-4698-8a41-5713c2bdc0f2	\N
78672d13-adf9-4915-8066-b3f95c708119	\N	idp-username-password-form	pkb-fhir	6a730924-0352-4698-8a41-5713c2bdc0f2	0	10	f	\N	\N
981736dc-ed84-409d-a968-360b5797d953	\N	\N	pkb-fhir	6a730924-0352-4698-8a41-5713c2bdc0f2	1	20	t	5ac83044-e7f5-4489-95a7-ac1405c16a68	\N
35482aa1-c8f6-4dbb-9b8b-f982ae72e183	\N	conditional-user-configured	pkb-fhir	5ac83044-e7f5-4489-95a7-ac1405c16a68	0	10	f	\N	\N
bf2c8930-b48a-419b-aa07-6244695d7a7d	\N	auth-otp-form	pkb-fhir	5ac83044-e7f5-4489-95a7-ac1405c16a68	0	20	f	\N	\N
7aa875a5-4fef-4c5f-b62d-c276faa53ea1	\N	http-basic-authenticator	pkb-fhir	a96dbb68-96ab-43d5-8da6-d6e77410fee9	0	10	f	\N	\N
04d3cbca-078e-4ef2-b05c-533b4170a88b	\N	docker-http-basic-authenticator	pkb-fhir	6cc7a277-b010-4c34-bfd0-1c98408a4ac3	0	10	f	\N	\N
8825f309-aa31-426a-be75-37bfc8f2d657	\N	no-cookie-redirect	pkb-fhir	945fe48f-f3d6-48e2-a32b-bddcb9db58c1	0	10	f	\N	\N
5d2edf4d-82f0-417a-a960-3f50255acd0d	\N	\N	pkb-fhir	945fe48f-f3d6-48e2-a32b-bddcb9db58c1	0	20	t	bfbccdd0-8ef5-4bbc-8680-6856fec07dd3	\N
7c73375f-519e-4d5f-93ef-50088000f2bc	\N	basic-auth	pkb-fhir	bfbccdd0-8ef5-4bbc-8680-6856fec07dd3	0	10	f	\N	\N
02fe8e16-87e8-462f-8b2a-8caebf899d87	\N	basic-auth-otp	pkb-fhir	bfbccdd0-8ef5-4bbc-8680-6856fec07dd3	3	20	f	\N	\N
4ab3e123-9a89-4cc1-8c9b-0c8ef9f557e4	\N	auth-spnego	pkb-fhir	bfbccdd0-8ef5-4bbc-8680-6856fec07dd3	3	30	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
e6d64ede-1a4b-4802-bd65-2cb3b5d068b2	browser	browser based authentication	master	basic-flow	t	t
0f3b5def-dbd0-40d9-a454-c7b0c2f192ac	forms	Username, password, otp and other auth forms.	master	basic-flow	f	t
4dd6498a-c197-49ec-9dfb-94bb760b380c	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
07a0ce42-da16-45fb-ae96-9964fca76605	direct grant	OpenID Connect Resource Owner Grant	master	basic-flow	t	t
7bddf36a-212d-49ee-b7d3-bf915b133caa	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
a4d154e3-b19b-4635-b8ba-a3b04a74b2d1	registration	registration flow	master	basic-flow	t	t
2928f7f6-5d95-47f7-a6be-052408853932	registration form	registration form	master	form-flow	f	t
a714b25d-bf21-4195-89b2-2e0a24de196c	reset credentials	Reset credentials for a user if they forgot their password or something	master	basic-flow	t	t
2f2896f9-c7a5-4196-ba89-42e29dfb13a2	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	master	basic-flow	f	t
40a1b354-9df0-4907-b6e2-90d10774663e	clients	Base authentication for clients	master	client-flow	t	t
f957dd9c-c56c-4343-a5fa-7e96aa063408	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	master	basic-flow	t	t
11fe21e9-8a0b-4559-b0a6-c9f217e7ad01	User creation or linking	Flow for the existing/non-existing user alternatives	master	basic-flow	f	t
c6b5431b-e73d-4ee3-8726-1b7a67e90332	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	master	basic-flow	f	t
5f91bf93-3ff3-40ee-a3f2-9729b3b1f008	Account verification options	Method with which to verity the existing account	master	basic-flow	f	t
c2ce910f-38f0-4cce-8ca0-1e4c2507cb6f	Verify Existing Account by Re-authentication	Reauthentication of existing account	master	basic-flow	f	t
ff10737f-ee94-41b7-8f73-4ed7e54d1da8	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
867bb7cb-db8b-43dc-8d8a-661f5b7e7023	saml ecp	SAML ECP Profile Authentication Flow	master	basic-flow	t	t
ef33e11d-e7fe-47f7-a760-ab561aea2c4e	docker auth	Used by Docker clients to authenticate against the IDP	master	basic-flow	t	t
6d95f7ba-d5e9-4b25-9461-e7e6b2b38708	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	master	basic-flow	t	t
855ae211-f592-4071-8300-023b04ad52e4	Authentication Options	Authentication options.	master	basic-flow	f	t
8adafb64-f5a8-424e-b79e-0f6646c6d6d0	browser	browser based authentication	pkb-fhir	basic-flow	t	t
30045454-5f32-4ace-a8bb-e28b0c5f7fe1	forms	Username, password, otp and other auth forms.	pkb-fhir	basic-flow	f	t
a28f4933-4d6e-4b21-ba87-9892c08f8d2e	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	pkb-fhir	basic-flow	f	t
16636059-937d-4ab2-90f8-c4ff5f1eec9f	direct grant	OpenID Connect Resource Owner Grant	pkb-fhir	basic-flow	t	t
47868bd0-5b1f-4aa0-a294-59ad2d1ed464	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	pkb-fhir	basic-flow	f	t
cf258020-dd88-4266-9e1c-fabaa0596805	registration	registration flow	pkb-fhir	basic-flow	t	t
d73efc3b-6855-47a9-99a5-0c869484c375	registration form	registration form	pkb-fhir	form-flow	f	t
d6fa4daf-3120-4007-a377-36d4841d3eff	reset credentials	Reset credentials for a user if they forgot their password or something	pkb-fhir	basic-flow	t	t
1616b88a-81d9-443e-9a91-127a94988203	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	pkb-fhir	basic-flow	f	t
60d9901a-81dd-4701-87b7-2338e93e2dfe	clients	Base authentication for clients	pkb-fhir	client-flow	t	t
0639f17b-ab0d-4791-bb0a-c38be03f435e	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	pkb-fhir	basic-flow	t	t
941c7b62-1fc7-4fd6-a77b-c85418484a36	User creation or linking	Flow for the existing/non-existing user alternatives	pkb-fhir	basic-flow	f	t
0c2772e5-1046-48ab-b16c-907e5bafe19d	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	pkb-fhir	basic-flow	f	t
410ed43c-d11b-44a6-886e-5a7714cb6255	Account verification options	Method with which to verity the existing account	pkb-fhir	basic-flow	f	t
6a730924-0352-4698-8a41-5713c2bdc0f2	Verify Existing Account by Re-authentication	Reauthentication of existing account	pkb-fhir	basic-flow	f	t
5ac83044-e7f5-4489-95a7-ac1405c16a68	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	pkb-fhir	basic-flow	f	t
a96dbb68-96ab-43d5-8da6-d6e77410fee9	saml ecp	SAML ECP Profile Authentication Flow	pkb-fhir	basic-flow	t	t
6cc7a277-b010-4c34-bfd0-1c98408a4ac3	docker auth	Used by Docker clients to authenticate against the IDP	pkb-fhir	basic-flow	t	t
945fe48f-f3d6-48e2-a32b-bddcb9db58c1	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	pkb-fhir	basic-flow	t	t
bfbccdd0-8ef5-4bbc-8680-6856fec07dd3	Authentication Options	Authentication options.	pkb-fhir	basic-flow	f	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
f0439edf-d491-43d9-b399-14d5464b5866	review profile config	master
77996143-1ede-4e0c-89f1-1f64659dd5bc	create unique user config	master
44a4a267-308e-4124-8d0a-d6a5939bb054	review profile config	pkb-fhir
911a23e6-dde5-4482-8a16-70ec63e7f05c	create unique user config	pkb-fhir
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
f0439edf-d491-43d9-b399-14d5464b5866	missing	update.profile.on.first.login
77996143-1ede-4e0c-89f1-1f64659dd5bc	false	require.password.update.after.registration
44a4a267-308e-4124-8d0a-d6a5939bb054	missing	update.profile.on.first.login
911a23e6-dde5-4482-8a16-70ec63e7f05c	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
57aed360-afb0-44a1-b480-f2b6f74bdab4	t	f	master-realm	0	f	\N	\N	t	\N	f	master	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
b4a9b818-2099-4d12-bfae-867f5ce288b3	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
12ddecff-fe86-4fec-9e67-fd3db715f772	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
5e06b450-a41d-4d8b-8ffc-3a1b5ec2fc42	t	f	broker	0	f	\N	\N	t	\N	f	master	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
0d2f3cc8-e788-4558-be62-c06c1581a14d	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	master	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
13b19b3f-d0ef-4564-9a50-bbe96f6130ef	t	f	admin-cli	0	t	\N	\N	f	\N	f	master	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
e7b4b8cc-790e-48fd-858c-bc5fffabeb41	t	f	pkb-fhir-realm	0	f	\N	\N	t	\N	f	master	\N	0	f	f	pkb-fhir Realm	f	client-secret	\N	\N	\N	t	f	f	f
fb21d241-3368-4331-8d58-5160a53744ee	t	f	realm-management	0	f	\N	\N	t	\N	f	pkb-fhir	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
9829268b-9da1-4fd0-a953-9078144d2774	t	f	account	0	t	\N	/realms/pkb-fhir/account/	f	\N	f	pkb-fhir	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
57b71758-9d62-4c0f-9b02-7ae1201e81a3	t	f	account-console	0	t	\N	/realms/pkb-fhir/account/	f	\N	f	pkb-fhir	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
68fdd712-9c7b-4e78-a445-24332f8c65e1	t	f	broker	0	f	\N	\N	t	\N	f	pkb-fhir	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
2496af99-dc8b-4bad-afea-9c1be3d8c437	t	f	security-admin-console	0	t	\N	/admin/pkb-fhir/console/	f	\N	f	pkb-fhir	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
5cc44fd3-b17a-49fb-b396-f4d32012c603	t	f	admin-cli	0	t	\N	\N	f	\N	f	pkb-fhir	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
13cb01d4-5629-41b8-a27c-ba6519581c0e	t	t	pkb-fhir	0	t	\N	/	f	http://fakepkb.local	f	pkb-fhir	openid-connect	-1	f	f	\N	f	client-secret	http://fakepkb.local	\N	\N	t	f	t	f
f18864b2-c169-4a00-acd7-dc790bd2cd6e	t	t	pkb-fhir-resource	0	f	\N	\N	t	http://fakepkb.local/fhir	f	pkb-fhir	openid-connect	-1	f	f	pkb-fhir-resource	f	client-secret	http://localhost/fhir	PKB FHIR API server	\N	t	f	t	f
3ddef2a9-f6a2-475f-af73-33d10d6508d5	t	t	pkb-fhir-system	0	f	9f09b3f0-a255-4532-b0b6-ea6b5a726968	\N	f	\N	f	pkb-fhir	openid-connect	-1	f	f	\N	t	client-secret	\N	\N	\N	t	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_attributes (client_id, value, name) FROM stdin;
12ddecff-fe86-4fec-9e67-fd3db715f772	S256	pkce.code.challenge.method
0d2f3cc8-e788-4558-be62-c06c1581a14d	S256	pkce.code.challenge.method
57b71758-9d62-4c0f-9b02-7ae1201e81a3	S256	pkce.code.challenge.method
2496af99-dc8b-4bad-afea-9c1be3d8c437	S256	pkce.code.challenge.method
13cb01d4-5629-41b8-a27c-ba6519581c0e	false	saml.assertion.signature
13cb01d4-5629-41b8-a27c-ba6519581c0e	false	saml.force.post.binding
13cb01d4-5629-41b8-a27c-ba6519581c0e	false	saml.multivalued.roles
13cb01d4-5629-41b8-a27c-ba6519581c0e	false	saml.encrypt
13cb01d4-5629-41b8-a27c-ba6519581c0e	false	oauth2.device.authorization.grant.enabled
13cb01d4-5629-41b8-a27c-ba6519581c0e	false	backchannel.logout.revoke.offline.tokens
13cb01d4-5629-41b8-a27c-ba6519581c0e	false	saml.server.signature
13cb01d4-5629-41b8-a27c-ba6519581c0e	false	saml.server.signature.keyinfo.ext
13cb01d4-5629-41b8-a27c-ba6519581c0e	true	use.refresh.tokens
13cb01d4-5629-41b8-a27c-ba6519581c0e	false	exclude.session.state.from.auth.response
13cb01d4-5629-41b8-a27c-ba6519581c0e	false	oidc.ciba.grant.enabled
13cb01d4-5629-41b8-a27c-ba6519581c0e	false	saml.artifact.binding
13cb01d4-5629-41b8-a27c-ba6519581c0e	true	backchannel.logout.session.required
13cb01d4-5629-41b8-a27c-ba6519581c0e	false	client_credentials.use_refresh_token
13cb01d4-5629-41b8-a27c-ba6519581c0e	false	saml_force_name_id_format
13cb01d4-5629-41b8-a27c-ba6519581c0e	false	saml.client.signature
13cb01d4-5629-41b8-a27c-ba6519581c0e	false	tls.client.certificate.bound.access.tokens
13cb01d4-5629-41b8-a27c-ba6519581c0e	false	saml.authnstatement
13cb01d4-5629-41b8-a27c-ba6519581c0e	false	display.on.consent.screen
13cb01d4-5629-41b8-a27c-ba6519581c0e	false	saml.onetimeuse.condition
f18864b2-c169-4a00-acd7-dc790bd2cd6e	false	saml.assertion.signature
f18864b2-c169-4a00-acd7-dc790bd2cd6e	false	saml.force.post.binding
f18864b2-c169-4a00-acd7-dc790bd2cd6e	false	saml.multivalued.roles
f18864b2-c169-4a00-acd7-dc790bd2cd6e	false	saml.encrypt
f18864b2-c169-4a00-acd7-dc790bd2cd6e	false	oauth2.device.authorization.grant.enabled
f18864b2-c169-4a00-acd7-dc790bd2cd6e	false	backchannel.logout.revoke.offline.tokens
f18864b2-c169-4a00-acd7-dc790bd2cd6e	false	saml.server.signature
f18864b2-c169-4a00-acd7-dc790bd2cd6e	false	saml.server.signature.keyinfo.ext
f18864b2-c169-4a00-acd7-dc790bd2cd6e	true	use.refresh.tokens
f18864b2-c169-4a00-acd7-dc790bd2cd6e	false	exclude.session.state.from.auth.response
f18864b2-c169-4a00-acd7-dc790bd2cd6e	false	oidc.ciba.grant.enabled
f18864b2-c169-4a00-acd7-dc790bd2cd6e	false	saml.artifact.binding
f18864b2-c169-4a00-acd7-dc790bd2cd6e	true	backchannel.logout.session.required
f18864b2-c169-4a00-acd7-dc790bd2cd6e	false	client_credentials.use_refresh_token
f18864b2-c169-4a00-acd7-dc790bd2cd6e	false	saml_force_name_id_format
f18864b2-c169-4a00-acd7-dc790bd2cd6e	false	saml.client.signature
f18864b2-c169-4a00-acd7-dc790bd2cd6e	false	tls.client.certificate.bound.access.tokens
f18864b2-c169-4a00-acd7-dc790bd2cd6e	false	saml.authnstatement
f18864b2-c169-4a00-acd7-dc790bd2cd6e	false	display.on.consent.screen
f18864b2-c169-4a00-acd7-dc790bd2cd6e	false	saml.onetimeuse.condition
3ddef2a9-f6a2-475f-af73-33d10d6508d5	true	backchannel.logout.session.required
3ddef2a9-f6a2-475f-af73-33d10d6508d5	false	backchannel.logout.revoke.offline.tokens
3ddef2a9-f6a2-475f-af73-33d10d6508d5	false	saml.artifact.binding
3ddef2a9-f6a2-475f-af73-33d10d6508d5	false	saml.server.signature
3ddef2a9-f6a2-475f-af73-33d10d6508d5	false	saml.server.signature.keyinfo.ext
3ddef2a9-f6a2-475f-af73-33d10d6508d5	false	saml.assertion.signature
3ddef2a9-f6a2-475f-af73-33d10d6508d5	false	saml.client.signature
3ddef2a9-f6a2-475f-af73-33d10d6508d5	false	saml.encrypt
3ddef2a9-f6a2-475f-af73-33d10d6508d5	false	saml.authnstatement
3ddef2a9-f6a2-475f-af73-33d10d6508d5	false	saml.onetimeuse.condition
3ddef2a9-f6a2-475f-af73-33d10d6508d5	false	saml_force_name_id_format
3ddef2a9-f6a2-475f-af73-33d10d6508d5	false	saml.multivalued.roles
3ddef2a9-f6a2-475f-af73-33d10d6508d5	false	saml.force.post.binding
3ddef2a9-f6a2-475f-af73-33d10d6508d5	false	exclude.session.state.from.auth.response
3ddef2a9-f6a2-475f-af73-33d10d6508d5	false	oauth2.device.authorization.grant.enabled
3ddef2a9-f6a2-475f-af73-33d10d6508d5	false	oidc.ciba.grant.enabled
3ddef2a9-f6a2-475f-af73-33d10d6508d5	true	use.refresh.tokens
3ddef2a9-f6a2-475f-af73-33d10d6508d5	false	tls.client.certificate.bound.access.tokens
3ddef2a9-f6a2-475f-af73-33d10d6508d5	false	client_credentials.use_refresh_token
3ddef2a9-f6a2-475f-af73-33d10d6508d5	false	display.on.consent.screen
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
9cb3863a-5fcb-4477-a6b9-538e1d585843	offline_access	master	OpenID Connect built-in scope: offline_access	openid-connect
71086583-60cd-4512-841a-992363b4529e	role_list	master	SAML role list	saml
f5842f03-8ba4-4f78-8532-c5d702c08f57	profile	master	OpenID Connect built-in scope: profile	openid-connect
8746d31f-0308-4fad-b1fb-28aa452be4df	email	master	OpenID Connect built-in scope: email	openid-connect
bb0208e9-7a10-4953-992e-3b7ac9aaa24a	address	master	OpenID Connect built-in scope: address	openid-connect
f0614f6b-7fbc-4c9d-9f17-a315afa0d0f7	phone	master	OpenID Connect built-in scope: phone	openid-connect
c04562a0-ca6e-442c-b2e0-2bdb170d57e2	roles	master	OpenID Connect scope for add user roles to the access token	openid-connect
bfdc4612-6573-476d-9108-bf6f94fe52c6	web-origins	master	OpenID Connect scope for add allowed web origins to the access token	openid-connect
3edd4bad-a96b-49f2-a47a-3dffe24e7613	microprofile-jwt	master	Microprofile - JWT built-in scope	openid-connect
19515007-dd24-461d-aeaa-f8f050b2bf48	offline_access	pkb-fhir	OpenID Connect built-in scope: offline_access	openid-connect
939796f2-cff0-4672-8835-01b221e8610a	role_list	pkb-fhir	SAML role list	saml
e44e2e32-86dd-43b5-abdc-8f0aac0b1878	profile	pkb-fhir	OpenID Connect built-in scope: profile	openid-connect
dca024ab-f75f-4254-852c-ef9ac1689786	email	pkb-fhir	OpenID Connect built-in scope: email	openid-connect
a8ca61dd-f593-41b4-95fe-aefa18d440a2	address	pkb-fhir	OpenID Connect built-in scope: address	openid-connect
2005b049-0070-4d70-85dc-7c36f79223f2	phone	pkb-fhir	OpenID Connect built-in scope: phone	openid-connect
7a8ced8c-d7c4-490d-b8a9-fb678e937992	roles	pkb-fhir	OpenID Connect scope for add user roles to the access token	openid-connect
a8871684-4222-4538-9574-a8dd09ae7d2a	web-origins	pkb-fhir	OpenID Connect scope for add allowed web origins to the access token	openid-connect
a7695dab-7607-4f28-a76e-d7995b7a8fcd	microprofile-jwt	pkb-fhir	Microprofile - JWT built-in scope	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
9cb3863a-5fcb-4477-a6b9-538e1d585843	true	display.on.consent.screen
9cb3863a-5fcb-4477-a6b9-538e1d585843	${offlineAccessScopeConsentText}	consent.screen.text
71086583-60cd-4512-841a-992363b4529e	true	display.on.consent.screen
71086583-60cd-4512-841a-992363b4529e	${samlRoleListScopeConsentText}	consent.screen.text
f5842f03-8ba4-4f78-8532-c5d702c08f57	true	display.on.consent.screen
f5842f03-8ba4-4f78-8532-c5d702c08f57	${profileScopeConsentText}	consent.screen.text
f5842f03-8ba4-4f78-8532-c5d702c08f57	true	include.in.token.scope
8746d31f-0308-4fad-b1fb-28aa452be4df	true	display.on.consent.screen
8746d31f-0308-4fad-b1fb-28aa452be4df	${emailScopeConsentText}	consent.screen.text
8746d31f-0308-4fad-b1fb-28aa452be4df	true	include.in.token.scope
bb0208e9-7a10-4953-992e-3b7ac9aaa24a	true	display.on.consent.screen
bb0208e9-7a10-4953-992e-3b7ac9aaa24a	${addressScopeConsentText}	consent.screen.text
bb0208e9-7a10-4953-992e-3b7ac9aaa24a	true	include.in.token.scope
f0614f6b-7fbc-4c9d-9f17-a315afa0d0f7	true	display.on.consent.screen
f0614f6b-7fbc-4c9d-9f17-a315afa0d0f7	${phoneScopeConsentText}	consent.screen.text
f0614f6b-7fbc-4c9d-9f17-a315afa0d0f7	true	include.in.token.scope
c04562a0-ca6e-442c-b2e0-2bdb170d57e2	true	display.on.consent.screen
c04562a0-ca6e-442c-b2e0-2bdb170d57e2	${rolesScopeConsentText}	consent.screen.text
c04562a0-ca6e-442c-b2e0-2bdb170d57e2	false	include.in.token.scope
bfdc4612-6573-476d-9108-bf6f94fe52c6	false	display.on.consent.screen
bfdc4612-6573-476d-9108-bf6f94fe52c6		consent.screen.text
bfdc4612-6573-476d-9108-bf6f94fe52c6	false	include.in.token.scope
3edd4bad-a96b-49f2-a47a-3dffe24e7613	false	display.on.consent.screen
3edd4bad-a96b-49f2-a47a-3dffe24e7613	true	include.in.token.scope
19515007-dd24-461d-aeaa-f8f050b2bf48	true	display.on.consent.screen
19515007-dd24-461d-aeaa-f8f050b2bf48	${offlineAccessScopeConsentText}	consent.screen.text
939796f2-cff0-4672-8835-01b221e8610a	true	display.on.consent.screen
939796f2-cff0-4672-8835-01b221e8610a	${samlRoleListScopeConsentText}	consent.screen.text
e44e2e32-86dd-43b5-abdc-8f0aac0b1878	true	display.on.consent.screen
e44e2e32-86dd-43b5-abdc-8f0aac0b1878	${profileScopeConsentText}	consent.screen.text
e44e2e32-86dd-43b5-abdc-8f0aac0b1878	true	include.in.token.scope
dca024ab-f75f-4254-852c-ef9ac1689786	true	display.on.consent.screen
dca024ab-f75f-4254-852c-ef9ac1689786	${emailScopeConsentText}	consent.screen.text
dca024ab-f75f-4254-852c-ef9ac1689786	true	include.in.token.scope
a8ca61dd-f593-41b4-95fe-aefa18d440a2	true	display.on.consent.screen
a8ca61dd-f593-41b4-95fe-aefa18d440a2	${addressScopeConsentText}	consent.screen.text
a8ca61dd-f593-41b4-95fe-aefa18d440a2	true	include.in.token.scope
2005b049-0070-4d70-85dc-7c36f79223f2	true	display.on.consent.screen
2005b049-0070-4d70-85dc-7c36f79223f2	${phoneScopeConsentText}	consent.screen.text
2005b049-0070-4d70-85dc-7c36f79223f2	true	include.in.token.scope
7a8ced8c-d7c4-490d-b8a9-fb678e937992	true	display.on.consent.screen
7a8ced8c-d7c4-490d-b8a9-fb678e937992	${rolesScopeConsentText}	consent.screen.text
7a8ced8c-d7c4-490d-b8a9-fb678e937992	false	include.in.token.scope
a8871684-4222-4538-9574-a8dd09ae7d2a	false	display.on.consent.screen
a8871684-4222-4538-9574-a8dd09ae7d2a		consent.screen.text
a8871684-4222-4538-9574-a8dd09ae7d2a	false	include.in.token.scope
a7695dab-7607-4f28-a76e-d7995b7a8fcd	false	display.on.consent.screen
a7695dab-7607-4f28-a76e-d7995b7a8fcd	true	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
b4a9b818-2099-4d12-bfae-867f5ce288b3	f5842f03-8ba4-4f78-8532-c5d702c08f57	t
b4a9b818-2099-4d12-bfae-867f5ce288b3	8746d31f-0308-4fad-b1fb-28aa452be4df	t
b4a9b818-2099-4d12-bfae-867f5ce288b3	c04562a0-ca6e-442c-b2e0-2bdb170d57e2	t
b4a9b818-2099-4d12-bfae-867f5ce288b3	bfdc4612-6573-476d-9108-bf6f94fe52c6	t
b4a9b818-2099-4d12-bfae-867f5ce288b3	bb0208e9-7a10-4953-992e-3b7ac9aaa24a	f
b4a9b818-2099-4d12-bfae-867f5ce288b3	3edd4bad-a96b-49f2-a47a-3dffe24e7613	f
b4a9b818-2099-4d12-bfae-867f5ce288b3	f0614f6b-7fbc-4c9d-9f17-a315afa0d0f7	f
b4a9b818-2099-4d12-bfae-867f5ce288b3	9cb3863a-5fcb-4477-a6b9-538e1d585843	f
12ddecff-fe86-4fec-9e67-fd3db715f772	f5842f03-8ba4-4f78-8532-c5d702c08f57	t
12ddecff-fe86-4fec-9e67-fd3db715f772	8746d31f-0308-4fad-b1fb-28aa452be4df	t
12ddecff-fe86-4fec-9e67-fd3db715f772	c04562a0-ca6e-442c-b2e0-2bdb170d57e2	t
12ddecff-fe86-4fec-9e67-fd3db715f772	bfdc4612-6573-476d-9108-bf6f94fe52c6	t
12ddecff-fe86-4fec-9e67-fd3db715f772	bb0208e9-7a10-4953-992e-3b7ac9aaa24a	f
12ddecff-fe86-4fec-9e67-fd3db715f772	3edd4bad-a96b-49f2-a47a-3dffe24e7613	f
12ddecff-fe86-4fec-9e67-fd3db715f772	f0614f6b-7fbc-4c9d-9f17-a315afa0d0f7	f
12ddecff-fe86-4fec-9e67-fd3db715f772	9cb3863a-5fcb-4477-a6b9-538e1d585843	f
13b19b3f-d0ef-4564-9a50-bbe96f6130ef	f5842f03-8ba4-4f78-8532-c5d702c08f57	t
13b19b3f-d0ef-4564-9a50-bbe96f6130ef	8746d31f-0308-4fad-b1fb-28aa452be4df	t
13b19b3f-d0ef-4564-9a50-bbe96f6130ef	c04562a0-ca6e-442c-b2e0-2bdb170d57e2	t
13b19b3f-d0ef-4564-9a50-bbe96f6130ef	bfdc4612-6573-476d-9108-bf6f94fe52c6	t
13b19b3f-d0ef-4564-9a50-bbe96f6130ef	bb0208e9-7a10-4953-992e-3b7ac9aaa24a	f
13b19b3f-d0ef-4564-9a50-bbe96f6130ef	3edd4bad-a96b-49f2-a47a-3dffe24e7613	f
13b19b3f-d0ef-4564-9a50-bbe96f6130ef	f0614f6b-7fbc-4c9d-9f17-a315afa0d0f7	f
13b19b3f-d0ef-4564-9a50-bbe96f6130ef	9cb3863a-5fcb-4477-a6b9-538e1d585843	f
5e06b450-a41d-4d8b-8ffc-3a1b5ec2fc42	f5842f03-8ba4-4f78-8532-c5d702c08f57	t
5e06b450-a41d-4d8b-8ffc-3a1b5ec2fc42	8746d31f-0308-4fad-b1fb-28aa452be4df	t
5e06b450-a41d-4d8b-8ffc-3a1b5ec2fc42	c04562a0-ca6e-442c-b2e0-2bdb170d57e2	t
5e06b450-a41d-4d8b-8ffc-3a1b5ec2fc42	bfdc4612-6573-476d-9108-bf6f94fe52c6	t
5e06b450-a41d-4d8b-8ffc-3a1b5ec2fc42	bb0208e9-7a10-4953-992e-3b7ac9aaa24a	f
5e06b450-a41d-4d8b-8ffc-3a1b5ec2fc42	3edd4bad-a96b-49f2-a47a-3dffe24e7613	f
5e06b450-a41d-4d8b-8ffc-3a1b5ec2fc42	f0614f6b-7fbc-4c9d-9f17-a315afa0d0f7	f
5e06b450-a41d-4d8b-8ffc-3a1b5ec2fc42	9cb3863a-5fcb-4477-a6b9-538e1d585843	f
57aed360-afb0-44a1-b480-f2b6f74bdab4	f5842f03-8ba4-4f78-8532-c5d702c08f57	t
57aed360-afb0-44a1-b480-f2b6f74bdab4	8746d31f-0308-4fad-b1fb-28aa452be4df	t
57aed360-afb0-44a1-b480-f2b6f74bdab4	c04562a0-ca6e-442c-b2e0-2bdb170d57e2	t
57aed360-afb0-44a1-b480-f2b6f74bdab4	bfdc4612-6573-476d-9108-bf6f94fe52c6	t
57aed360-afb0-44a1-b480-f2b6f74bdab4	bb0208e9-7a10-4953-992e-3b7ac9aaa24a	f
57aed360-afb0-44a1-b480-f2b6f74bdab4	3edd4bad-a96b-49f2-a47a-3dffe24e7613	f
57aed360-afb0-44a1-b480-f2b6f74bdab4	f0614f6b-7fbc-4c9d-9f17-a315afa0d0f7	f
57aed360-afb0-44a1-b480-f2b6f74bdab4	9cb3863a-5fcb-4477-a6b9-538e1d585843	f
0d2f3cc8-e788-4558-be62-c06c1581a14d	f5842f03-8ba4-4f78-8532-c5d702c08f57	t
0d2f3cc8-e788-4558-be62-c06c1581a14d	8746d31f-0308-4fad-b1fb-28aa452be4df	t
0d2f3cc8-e788-4558-be62-c06c1581a14d	c04562a0-ca6e-442c-b2e0-2bdb170d57e2	t
0d2f3cc8-e788-4558-be62-c06c1581a14d	bfdc4612-6573-476d-9108-bf6f94fe52c6	t
0d2f3cc8-e788-4558-be62-c06c1581a14d	bb0208e9-7a10-4953-992e-3b7ac9aaa24a	f
0d2f3cc8-e788-4558-be62-c06c1581a14d	3edd4bad-a96b-49f2-a47a-3dffe24e7613	f
0d2f3cc8-e788-4558-be62-c06c1581a14d	f0614f6b-7fbc-4c9d-9f17-a315afa0d0f7	f
0d2f3cc8-e788-4558-be62-c06c1581a14d	9cb3863a-5fcb-4477-a6b9-538e1d585843	f
9829268b-9da1-4fd0-a953-9078144d2774	dca024ab-f75f-4254-852c-ef9ac1689786	t
9829268b-9da1-4fd0-a953-9078144d2774	a8871684-4222-4538-9574-a8dd09ae7d2a	t
9829268b-9da1-4fd0-a953-9078144d2774	e44e2e32-86dd-43b5-abdc-8f0aac0b1878	t
9829268b-9da1-4fd0-a953-9078144d2774	7a8ced8c-d7c4-490d-b8a9-fb678e937992	t
9829268b-9da1-4fd0-a953-9078144d2774	a7695dab-7607-4f28-a76e-d7995b7a8fcd	f
9829268b-9da1-4fd0-a953-9078144d2774	19515007-dd24-461d-aeaa-f8f050b2bf48	f
9829268b-9da1-4fd0-a953-9078144d2774	2005b049-0070-4d70-85dc-7c36f79223f2	f
9829268b-9da1-4fd0-a953-9078144d2774	a8ca61dd-f593-41b4-95fe-aefa18d440a2	f
57b71758-9d62-4c0f-9b02-7ae1201e81a3	dca024ab-f75f-4254-852c-ef9ac1689786	t
57b71758-9d62-4c0f-9b02-7ae1201e81a3	a8871684-4222-4538-9574-a8dd09ae7d2a	t
57b71758-9d62-4c0f-9b02-7ae1201e81a3	e44e2e32-86dd-43b5-abdc-8f0aac0b1878	t
57b71758-9d62-4c0f-9b02-7ae1201e81a3	7a8ced8c-d7c4-490d-b8a9-fb678e937992	t
57b71758-9d62-4c0f-9b02-7ae1201e81a3	a7695dab-7607-4f28-a76e-d7995b7a8fcd	f
57b71758-9d62-4c0f-9b02-7ae1201e81a3	19515007-dd24-461d-aeaa-f8f050b2bf48	f
57b71758-9d62-4c0f-9b02-7ae1201e81a3	2005b049-0070-4d70-85dc-7c36f79223f2	f
57b71758-9d62-4c0f-9b02-7ae1201e81a3	a8ca61dd-f593-41b4-95fe-aefa18d440a2	f
5cc44fd3-b17a-49fb-b396-f4d32012c603	dca024ab-f75f-4254-852c-ef9ac1689786	t
5cc44fd3-b17a-49fb-b396-f4d32012c603	a8871684-4222-4538-9574-a8dd09ae7d2a	t
5cc44fd3-b17a-49fb-b396-f4d32012c603	e44e2e32-86dd-43b5-abdc-8f0aac0b1878	t
5cc44fd3-b17a-49fb-b396-f4d32012c603	7a8ced8c-d7c4-490d-b8a9-fb678e937992	t
5cc44fd3-b17a-49fb-b396-f4d32012c603	a7695dab-7607-4f28-a76e-d7995b7a8fcd	f
5cc44fd3-b17a-49fb-b396-f4d32012c603	19515007-dd24-461d-aeaa-f8f050b2bf48	f
5cc44fd3-b17a-49fb-b396-f4d32012c603	2005b049-0070-4d70-85dc-7c36f79223f2	f
5cc44fd3-b17a-49fb-b396-f4d32012c603	a8ca61dd-f593-41b4-95fe-aefa18d440a2	f
68fdd712-9c7b-4e78-a445-24332f8c65e1	dca024ab-f75f-4254-852c-ef9ac1689786	t
68fdd712-9c7b-4e78-a445-24332f8c65e1	a8871684-4222-4538-9574-a8dd09ae7d2a	t
68fdd712-9c7b-4e78-a445-24332f8c65e1	e44e2e32-86dd-43b5-abdc-8f0aac0b1878	t
68fdd712-9c7b-4e78-a445-24332f8c65e1	7a8ced8c-d7c4-490d-b8a9-fb678e937992	t
68fdd712-9c7b-4e78-a445-24332f8c65e1	a7695dab-7607-4f28-a76e-d7995b7a8fcd	f
68fdd712-9c7b-4e78-a445-24332f8c65e1	19515007-dd24-461d-aeaa-f8f050b2bf48	f
68fdd712-9c7b-4e78-a445-24332f8c65e1	2005b049-0070-4d70-85dc-7c36f79223f2	f
68fdd712-9c7b-4e78-a445-24332f8c65e1	a8ca61dd-f593-41b4-95fe-aefa18d440a2	f
fb21d241-3368-4331-8d58-5160a53744ee	dca024ab-f75f-4254-852c-ef9ac1689786	t
fb21d241-3368-4331-8d58-5160a53744ee	a8871684-4222-4538-9574-a8dd09ae7d2a	t
fb21d241-3368-4331-8d58-5160a53744ee	e44e2e32-86dd-43b5-abdc-8f0aac0b1878	t
fb21d241-3368-4331-8d58-5160a53744ee	7a8ced8c-d7c4-490d-b8a9-fb678e937992	t
fb21d241-3368-4331-8d58-5160a53744ee	a7695dab-7607-4f28-a76e-d7995b7a8fcd	f
fb21d241-3368-4331-8d58-5160a53744ee	19515007-dd24-461d-aeaa-f8f050b2bf48	f
fb21d241-3368-4331-8d58-5160a53744ee	2005b049-0070-4d70-85dc-7c36f79223f2	f
fb21d241-3368-4331-8d58-5160a53744ee	a8ca61dd-f593-41b4-95fe-aefa18d440a2	f
2496af99-dc8b-4bad-afea-9c1be3d8c437	dca024ab-f75f-4254-852c-ef9ac1689786	t
2496af99-dc8b-4bad-afea-9c1be3d8c437	a8871684-4222-4538-9574-a8dd09ae7d2a	t
2496af99-dc8b-4bad-afea-9c1be3d8c437	e44e2e32-86dd-43b5-abdc-8f0aac0b1878	t
2496af99-dc8b-4bad-afea-9c1be3d8c437	7a8ced8c-d7c4-490d-b8a9-fb678e937992	t
2496af99-dc8b-4bad-afea-9c1be3d8c437	a7695dab-7607-4f28-a76e-d7995b7a8fcd	f
2496af99-dc8b-4bad-afea-9c1be3d8c437	19515007-dd24-461d-aeaa-f8f050b2bf48	f
2496af99-dc8b-4bad-afea-9c1be3d8c437	2005b049-0070-4d70-85dc-7c36f79223f2	f
2496af99-dc8b-4bad-afea-9c1be3d8c437	a8ca61dd-f593-41b4-95fe-aefa18d440a2	f
13cb01d4-5629-41b8-a27c-ba6519581c0e	a8871684-4222-4538-9574-a8dd09ae7d2a	t
13cb01d4-5629-41b8-a27c-ba6519581c0e	e44e2e32-86dd-43b5-abdc-8f0aac0b1878	t
13cb01d4-5629-41b8-a27c-ba6519581c0e	7a8ced8c-d7c4-490d-b8a9-fb678e937992	t
13cb01d4-5629-41b8-a27c-ba6519581c0e	dca024ab-f75f-4254-852c-ef9ac1689786	t
13cb01d4-5629-41b8-a27c-ba6519581c0e	a8ca61dd-f593-41b4-95fe-aefa18d440a2	f
13cb01d4-5629-41b8-a27c-ba6519581c0e	2005b049-0070-4d70-85dc-7c36f79223f2	f
13cb01d4-5629-41b8-a27c-ba6519581c0e	19515007-dd24-461d-aeaa-f8f050b2bf48	f
13cb01d4-5629-41b8-a27c-ba6519581c0e	a7695dab-7607-4f28-a76e-d7995b7a8fcd	f
f18864b2-c169-4a00-acd7-dc790bd2cd6e	a8871684-4222-4538-9574-a8dd09ae7d2a	t
f18864b2-c169-4a00-acd7-dc790bd2cd6e	e44e2e32-86dd-43b5-abdc-8f0aac0b1878	t
f18864b2-c169-4a00-acd7-dc790bd2cd6e	7a8ced8c-d7c4-490d-b8a9-fb678e937992	t
f18864b2-c169-4a00-acd7-dc790bd2cd6e	dca024ab-f75f-4254-852c-ef9ac1689786	t
f18864b2-c169-4a00-acd7-dc790bd2cd6e	a8ca61dd-f593-41b4-95fe-aefa18d440a2	f
f18864b2-c169-4a00-acd7-dc790bd2cd6e	2005b049-0070-4d70-85dc-7c36f79223f2	f
f18864b2-c169-4a00-acd7-dc790bd2cd6e	19515007-dd24-461d-aeaa-f8f050b2bf48	f
f18864b2-c169-4a00-acd7-dc790bd2cd6e	a7695dab-7607-4f28-a76e-d7995b7a8fcd	f
3ddef2a9-f6a2-475f-af73-33d10d6508d5	dca024ab-f75f-4254-852c-ef9ac1689786	t
3ddef2a9-f6a2-475f-af73-33d10d6508d5	a8871684-4222-4538-9574-a8dd09ae7d2a	t
3ddef2a9-f6a2-475f-af73-33d10d6508d5	e44e2e32-86dd-43b5-abdc-8f0aac0b1878	t
3ddef2a9-f6a2-475f-af73-33d10d6508d5	7a8ced8c-d7c4-490d-b8a9-fb678e937992	t
3ddef2a9-f6a2-475f-af73-33d10d6508d5	a7695dab-7607-4f28-a76e-d7995b7a8fcd	f
3ddef2a9-f6a2-475f-af73-33d10d6508d5	19515007-dd24-461d-aeaa-f8f050b2bf48	f
3ddef2a9-f6a2-475f-af73-33d10d6508d5	2005b049-0070-4d70-85dc-7c36f79223f2	f
3ddef2a9-f6a2-475f-af73-33d10d6508d5	a8ca61dd-f593-41b4-95fe-aefa18d440a2	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
9cb3863a-5fcb-4477-a6b9-538e1d585843	90846143-ce86-4f98-8632-40d96c31b2b0
19515007-dd24-461d-aeaa-f8f050b2bf48	4b2c8957-599d-406c-9956-b4c4d67bd86c
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
257a80d9-4674-427e-9336-1d2d6592d295	Trusted Hosts	master	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
9f740151-4915-4ff2-9f74-6f701da92521	Consent Required	master	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
cef4be25-3863-44b3-9353-7016f7514864	Full Scope Disabled	master	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
411f7c80-bf26-4216-a3a9-8592655b344b	Max Clients Limit	master	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
e1da4e0b-b842-41b6-b6b2-03752e2500d6	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
d038c462-7a0c-4e4a-a65c-55ed657f0311	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
f6bfa8e5-a480-4b9d-b8a0-44549714a13e	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
fbef5344-ad23-4d01-9b06-8fa3b9e640f6	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
3c266d98-9206-456d-8b82-908f3aea7123	rsa-generated	master	rsa-generated	org.keycloak.keys.KeyProvider	master	\N
1259e841-34b9-432e-9f77-4ae911ff29f9	hmac-generated	master	hmac-generated	org.keycloak.keys.KeyProvider	master	\N
45b18ee5-776c-4343-8dec-cc5ff6c7bca3	aes-generated	master	aes-generated	org.keycloak.keys.KeyProvider	master	\N
4552198b-226e-445f-9184-349702325819	rsa-generated	pkb-fhir	rsa-generated	org.keycloak.keys.KeyProvider	pkb-fhir	\N
b3dab6b1-e1d7-44f1-abe3-5b641b7706f8	hmac-generated	pkb-fhir	hmac-generated	org.keycloak.keys.KeyProvider	pkb-fhir	\N
a4d1b7ad-0654-49e4-923d-3aeff07e687b	aes-generated	pkb-fhir	aes-generated	org.keycloak.keys.KeyProvider	pkb-fhir	\N
df8a1e3e-e952-4e32-be33-ba69dd725bed	Trusted Hosts	pkb-fhir	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	pkb-fhir	anonymous
0cfeecf2-f676-4290-9ebd-d58124c44985	Consent Required	pkb-fhir	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	pkb-fhir	anonymous
4e34cb8b-4e69-4108-816a-bacd60a5c16d	Full Scope Disabled	pkb-fhir	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	pkb-fhir	anonymous
c787e905-4fc0-4a5c-a20c-28b14ce766f3	Max Clients Limit	pkb-fhir	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	pkb-fhir	anonymous
7e27d870-24b0-4e90-9d48-0e6b938b0946	Allowed Protocol Mapper Types	pkb-fhir	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	pkb-fhir	anonymous
9e513644-3419-48bd-b190-7ccdcb3f6690	Allowed Client Scopes	pkb-fhir	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	pkb-fhir	anonymous
3a9c147c-0343-4fa5-9afd-99bfcf49f3f5	Allowed Protocol Mapper Types	pkb-fhir	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	pkb-fhir	authenticated
e3cf55f4-f4f9-47ed-85fd-2a9a1440b73c	Allowed Client Scopes	pkb-fhir	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	pkb-fhir	authenticated
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
4fa169e1-80ee-48ab-ab6a-fd3ee14d4565	d038c462-7a0c-4e4a-a65c-55ed657f0311	allow-default-scopes	true
da7b7c57-6e22-4dcc-a911-a576103d7808	411f7c80-bf26-4216-a3a9-8592655b344b	max-clients	200
680916ba-2118-4abc-abf4-b4ea7beee723	e1da4e0b-b842-41b6-b6b2-03752e2500d6	allowed-protocol-mapper-types	saml-user-property-mapper
5737045a-df7e-4f4b-8ba0-270e96f0fe41	e1da4e0b-b842-41b6-b6b2-03752e2500d6	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
4b1d2de7-335b-4eac-9429-a6e1bf8fae70	e1da4e0b-b842-41b6-b6b2-03752e2500d6	allowed-protocol-mapper-types	saml-role-list-mapper
f2a1e442-b11b-4d8a-b1c9-e8768d8ec228	e1da4e0b-b842-41b6-b6b2-03752e2500d6	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
27f903b3-2b8c-4156-b652-dae48b4f18b7	e1da4e0b-b842-41b6-b6b2-03752e2500d6	allowed-protocol-mapper-types	saml-user-attribute-mapper
5e8d0032-5d75-4286-b9c4-48d878ec8510	e1da4e0b-b842-41b6-b6b2-03752e2500d6	allowed-protocol-mapper-types	oidc-full-name-mapper
967c3bef-8b2c-4ea8-a147-50441745f384	e1da4e0b-b842-41b6-b6b2-03752e2500d6	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
0d18e22f-5c65-40ea-93ae-b239712dee62	e1da4e0b-b842-41b6-b6b2-03752e2500d6	allowed-protocol-mapper-types	oidc-address-mapper
2a816a2c-86cd-4bd5-b6ad-cabc28e0475d	f6bfa8e5-a480-4b9d-b8a0-44549714a13e	allowed-protocol-mapper-types	oidc-full-name-mapper
c895aebc-a38f-4f9c-a3a2-33ebf8ac7a47	f6bfa8e5-a480-4b9d-b8a0-44549714a13e	allowed-protocol-mapper-types	oidc-address-mapper
7786e87d-0bf4-4105-811d-58b17d46edbe	f6bfa8e5-a480-4b9d-b8a0-44549714a13e	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
dd8eed8a-c3dc-43b1-8c82-f041800720ff	f6bfa8e5-a480-4b9d-b8a0-44549714a13e	allowed-protocol-mapper-types	saml-role-list-mapper
0cc8de93-e6ec-4126-8b68-fc54f6590691	f6bfa8e5-a480-4b9d-b8a0-44549714a13e	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
48687942-5f04-4c83-abd7-08d88cea7e6a	f6bfa8e5-a480-4b9d-b8a0-44549714a13e	allowed-protocol-mapper-types	saml-user-attribute-mapper
99662712-8ea5-4d34-a6e8-c67527c571b1	f6bfa8e5-a480-4b9d-b8a0-44549714a13e	allowed-protocol-mapper-types	saml-user-property-mapper
23811370-20e2-4483-ab96-c1517c8cd7aa	f6bfa8e5-a480-4b9d-b8a0-44549714a13e	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
d8998c18-422c-49de-8385-91a15c2b77cd	fbef5344-ad23-4d01-9b06-8fa3b9e640f6	allow-default-scopes	true
9211017c-bc1f-40d9-bc4b-7586407fa1ad	257a80d9-4674-427e-9336-1d2d6592d295	host-sending-registration-request-must-match	true
c25b2a28-2bd6-4b17-987f-7ef2d6d3fcef	257a80d9-4674-427e-9336-1d2d6592d295	client-uris-must-match	true
cc31e34d-f74e-4a4e-98f6-91b3cb8e5091	45b18ee5-776c-4343-8dec-cc5ff6c7bca3	kid	74491e34-4f8d-49fa-a9f8-7aa7675ce6c4
14e0a4ab-4ff3-47e6-bca5-ecd60bcb508a	45b18ee5-776c-4343-8dec-cc5ff6c7bca3	priority	100
603aa420-3507-4273-a327-914cce17dece	45b18ee5-776c-4343-8dec-cc5ff6c7bca3	secret	pevaX_6AdogRZK89A1iIiA
cf02e7ff-9bae-469e-a837-72ab1fc50387	1259e841-34b9-432e-9f77-4ae911ff29f9	algorithm	HS256
709ffb21-ddc1-40ad-a92b-00caf53def28	1259e841-34b9-432e-9f77-4ae911ff29f9	priority	100
8914f73f-10c3-4f4d-a847-9ef368b63541	1259e841-34b9-432e-9f77-4ae911ff29f9	kid	27a4b0b0-aec0-4bac-a86e-7d5c06e9408c
2c5d1db5-ec38-4789-a7f9-8fedb20f0770	1259e841-34b9-432e-9f77-4ae911ff29f9	secret	E9ezMogk2BhTYIPwbnj8rOgIk05nLcbB77ynwCGByMTBbKmWOtcHPnzOOprWP9TNhxoLjtZTWjMLl6pduqNQzQ
5c3d50ee-3464-4f8a-8fdb-3f7bc989addf	3c266d98-9206-456d-8b82-908f3aea7123	certificate	MIICmzCCAYMCBgF5YoIbUDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjEwNTEyMjEzNDI0WhcNMzEwNTEyMjEzNjA0WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCXDVFKVeGhPLsxtIxYi7Vv5323eP1LSKs/ntJ2HvUzyXQ//kPr/O66D43yjUZb7Qqf4ktKMYgUg/1iPO0KC7vo8C/S0/T/NM24ANrgp+zO/fAFu3fjfoyMf7sfVxOmyW1XRXtnS7yARxgGSTSwyZ3vrlQC75hfUEaMQabwugupArj3zgoIReYfzhExKyCg51NmQ94XQ338iy/o/TB9roGDs1ixkdLzzr/4xuEh4N8kGbizgPwSUmL1GSApLVWgEY6HJFXSIZwhPVipeyHqpeJS1hnVwbeWRykWqmDnbPPXrwGoZkGnrPA4UxRTJa4bt1P5dH8fnkVH0Jq6PwCjVyvXAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAEgrNCoX6lXSYRrK8V0FChRIvq8hpdhZxPs7ZX9KJfobbkKAg32BYOtSuv3Jq8v/VC+Leaq9uo2E706jGy7JqvFY3td5NjtAaKCNvVMBGTdNZgHXPPa8PAtphTXJSuHfIhsNKR576kdp4ZyZ15p8ETRuk77nts5zN33Vge/rx1ou5wkKq3wDP5DLA6Sf2J8xIAF9keV/MmGNlErTIWRqKn9ZuBwkxuQxQ61UfNEUfOIE1KG+Psdv+mKKOHzF7PU5SfRGlflZE4ARZmWqu1BP7+gPOfD7P4HKA6dHoGNA4PSpeNheHE+cJiv8zrGdGVMj94iJg+9txSH1g1j0t94BqEo=
4ef40948-deb7-4ced-a382-bfe1283d23fd	3c266d98-9206-456d-8b82-908f3aea7123	privateKey	MIIEogIBAAKCAQEAlw1RSlXhoTy7MbSMWIu1b+d9t3j9S0irP57Sdh71M8l0P/5D6/zuug+N8o1GW+0Kn+JLSjGIFIP9YjztCgu76PAv0tP0/zTNuADa4Kfszv3wBbt3436MjH+7H1cTpsltV0V7Z0u8gEcYBkk0sMmd765UAu+YX1BGjEGm8LoLqQK4984KCEXmH84RMSsgoOdTZkPeF0N9/Isv6P0wfa6Bg7NYsZHS886/+MbhIeDfJBm4s4D8ElJi9RkgKS1VoBGOhyRV0iGcIT1YqXsh6qXiUtYZ1cG3lkcpFqpg52zz168BqGZBp6zwOFMUUyWuG7dT+XR/H55FR9Cauj8Ao1cr1wIDAQABAoIBAEnlNPh1rSzQ5g758ZK7viYhjGn+YYO76DL2gqVQncoY6qsHu7iuAye4xkt7e4krHIB9FzITqyvGKmYtwhShCut43Rx5nqhe76jtmiY/YGUe65YSUSNU3HM7ZZJ+adm1Pq1sC2PMNEpY/VLN6131NDN2CBlrlxJB1lF1KLMpgNzL/G5wGO+3J9aDsO8MrdVLhos1gri1Lq8m5slroL+DCbM1pv6y6WorTBhd1I06jWhNtvGZ2jGNhzL62Nazy48PyH3f+UT5zqukORPaWXTyhXiywoU7/3Fo7LevnWFH3dNSp9IfhX1y7z7kmYMF5Wj98MkYngNBTSHdg8sKW+lpkukCgYEA0JawVMC5WMhl/WVTyZsiyd//jIXjPGPLbKgRjdbLEurxFAxBr1GQkbyadQwYmNuWaORGx8FGocauAYpFR/AhPWUi0GfPZ8YGwhFGlIUNWFEhSmuaYNRn/2nD+NLQZ3LuGSrlIjr9GbBL6q2dIWIpnC65ydslCTkD4IQh/jMM5vsCgYEAuWKzZ12SAFU26VXUSF7kFhtLWpCiWeI6cwcnvlFryVFbLM7ySQKGkYlUvvl/2Pb8xClB4yn+nRgTn7TNu8nc0lhi9VB9X4CheYmOyzh7ZjeV8oIABDUY3iaFgsAhbiVNeqMujBj+uNpytuRzQDcu7KaecvZ/7DmDW6SpT3pEZ9UCgYAE6GbBt78kraJoseekyLeq1FBo+AV+uEJjDhlLoxAoI8sEU71/6IVkSHHB60Tw48nIMgbQUGXfDJOviZdTt/ywOx70lFy27lveWRW2DONhfpcv7xQ0zwqbYduwkRVCOdwMT4wQoB6wagt/PBKEZJDiEd9hNnzKmMLUl4dNOdpF3QKBgBr92e0k3Isb3SDgFEZtOnxVgQUwpdK8c5In6ot1Q2JObB38C57BtWIfQq2Dmi+21lqhPyyaAq5QwRqxsnqzC2m84Lui+n4bNmeBtb60/JKHaVejweja6kH+DdZZrwRgfgVrGO3g/cVgWO90F6uz3Ssrn0pRxZJZVVzUfqpJvQf5AoGAbP7VwGrX0DPbtICU8eaos6Qhq6/B2KVSAvAoRBM/QisdrrvftGXlSP4mWZ1kSXIybAu3/A6FM+OrUCtFkdNXYTk4jJDVBr8SQgktetuvSQWNKlrSqoB3pIKejcNhI+PDEAEteYNX1+34soXcHgtYxk7+jLorpRukLm4j3CTx1Kg=
4d80b07a-c0d8-4ca5-ba0e-46f74dc9970e	3c266d98-9206-456d-8b82-908f3aea7123	priority	100
580d6cac-d58f-4917-95d3-897fbfe476cb	a4d1b7ad-0654-49e4-923d-3aeff07e687b	priority	100
57d742cf-d888-4a07-9a8d-adc2ccf9d7f1	a4d1b7ad-0654-49e4-923d-3aeff07e687b	secret	XdNaAVu-Utr0Xs3qaaoFZA
8b961acc-809b-45ee-8c5b-6ebdccf918f7	a4d1b7ad-0654-49e4-923d-3aeff07e687b	kid	e4dce174-8e74-4c5d-92aa-e2160ca8a0a5
f56a41d2-4f67-4814-a6aa-c7f3cbfa6c9d	4552198b-226e-445f-9184-349702325819	priority	100
f8710953-6dd1-4588-ad5d-33e67d29ea04	4552198b-226e-445f-9184-349702325819	certificate	MIICnzCCAYcCBgF5YoLkYzANBgkqhkiG9w0BAQsFADATMREwDwYDVQQDDAhwa2ItZmhpcjAeFw0yMTA1MTIyMTM1MTVaFw0zMTA1MTIyMTM2NTVaMBMxETAPBgNVBAMMCHBrYi1maGlyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAj53kgUybcqgf9C5ouGaLsVc7G+RneI0fKs4LKuzLe68oQQOfsC9aLJk+Osc73txi/qe1FRI1PlSAjOn2czyVFKG9+E7MH0GgmUiZFIK4sCg+apZOc4lmsnc+dUk6icCfwIs3uVGiTMW14hWcPvXrGAlbwVwsk7+Uf8QjiB27ph4zZNEdJYRdC06HCNmsA/pPuB4oQesWKf1Ynyky4HzpN71z7Mgyrtz9nwBtV/zmDTytp6gPiVKsP0sSBTV4UUgHYpEcULO/Dn7sZbXBjgmp+Kb0xToUUOMjdoquVY4YyyJTHuCaoFkiQQdpTEMp0rrX+tCnOQGLoL5yue8sec4pQwIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQAijyiuYi32U7xsrBtqnBwJqGskHO6kZqoAiyx0/2PkH+g/EXz8Dhnj6JNoChUnaf78UiV49jIjV5TpghFGJaknciBMNKiQiScqM5uMkHdDr+PxzaRhqCCsV2GcpW62ghJmfD5hECRkXevBIOK6SEaVD/1YUZ5EHA7S/hSowCeRDrmAgRY8aOVhv5bOuU7LxjDqhLZ+pCcQnqkbZvC9hfa0A7VAwJ0G6Thz3k7+WwvsQ6Uy9IiPfcizcLyNz8O39z57qr3KBXvU6LFAZK9YwrfVNQzsG0FSOJtqjZUg+pERTKvenLRyzshJ39uQSEnmqMDbmzhaJn1nCIZddgB2VwGx
51f59c2d-b7bf-46c5-96dc-383a500ecd6d	4552198b-226e-445f-9184-349702325819	privateKey	MIIEogIBAAKCAQEAj53kgUybcqgf9C5ouGaLsVc7G+RneI0fKs4LKuzLe68oQQOfsC9aLJk+Osc73txi/qe1FRI1PlSAjOn2czyVFKG9+E7MH0GgmUiZFIK4sCg+apZOc4lmsnc+dUk6icCfwIs3uVGiTMW14hWcPvXrGAlbwVwsk7+Uf8QjiB27ph4zZNEdJYRdC06HCNmsA/pPuB4oQesWKf1Ynyky4HzpN71z7Mgyrtz9nwBtV/zmDTytp6gPiVKsP0sSBTV4UUgHYpEcULO/Dn7sZbXBjgmp+Kb0xToUUOMjdoquVY4YyyJTHuCaoFkiQQdpTEMp0rrX+tCnOQGLoL5yue8sec4pQwIDAQABAoIBAEcG86fu10JRW9xLx4bLUHMYjScyQuogATYOSP+ltM0qx2HABQ4BnTtJXrl7J2UE4gDHuIr/Qk3dROZsH3LGl4RoqadQcStULbUhbnPyYpzcimH0jEAfyCajSsR+vvC5z0hOkfSZJweJEHcL8QZCYU618icjCvjXWv4FZv0+lzuEG7YvFDZWBIOiRHzjzV+9qHjl/dIkuzC2j7mvSwCdVsB9fSP/8dQdG5S1lIQsYWown06jVEgZMsFl0+N0AGhOBKFSyRlKA4FWzOoxcJ/dd+QWD5I80R3JMDE8R7YjqJSSTqpwAYD/585kp3FbWQFv7oUj3+jDTDIbBi9PruSZgAECgYEA47bsfbbPcEH+em23P3gYX8+f2QDt60EazxighvLnw3Jdl7WTVIC+gsY3D65gGW2BkzuCUmfd+/ZQgmYNxH8za8awwkm1X1j9mdOy71MXgFLYhJVlsnkKMZl0vR1rzYOUVEXO9hWejg2kp8QivrsSnd59MqSyx1XgbkGGPReeMAECgYEAoXTAHRljK7UCA1MBO7T2H6AYBVMacarKVVTghubJkNN2kBiFWl9ptK4AC0j+SJNUiixvQ8kcA/R+a8jsFktZCArF88JpZ81O6dzOIg5Z8sofinA+wwDebSci84GoCdEGj7Jw3X8fezlSWDcxvo44GlnZyBNBbUYKJqLC/XC3mUMCgYA15sHaDCDUKLrtDfV3b50NaN8khcTLkBChfunYp7zWlcazt4ZVVVhDKlo0OwmCW1p1mHuDuBRipO5vv2p43cc1NsX2Z24oUK9O7z6GyfthI7sevyJgeahBD1sDvOgcsI222QNhWsK6S15zW8kBrtR8TAMErtmmt5w1XQtCgMmwAQKBgH+K1fRmyLOPMr7jhDbhVghXlIIoStx+GYXdHd0TVSlmEuPzquxgMQW86mX/zHgSgpcAUQjQRqRNMMz+lJlr/jHfKM7NxixswCj395Jpmd60ksPutXWgKxU49GA+DTtr9u3u/T/MG1dhSc5ME6y/dkxCrEpkA6xJxt0MeFJzB2Y3AoGAddd4kXvrYjOZxEnUQoUaXjrk4k7xm5AFYbi3TbIi3DvUiEac38LkA68T7HZFo4oaamRixkHyApHEAxB5A9aGx1Ve5sqO1UhaqPo9syJAcs/SSSnX9dd/7BMitvtdxvxIXD0/4IOvExabWt70EGl/APURiK7J4eiFIA2S3W9iHew=
519d7a50-fe5e-4506-bef3-34ab6aa62170	b3dab6b1-e1d7-44f1-abe3-5b641b7706f8	kid	1a490a32-c42d-417a-9a84-e8be5e439194
f8d5bd4a-869d-4e6b-b950-b503aaafa090	b3dab6b1-e1d7-44f1-abe3-5b641b7706f8	priority	100
3e6858ee-32c5-4013-a659-5d863f8ed964	b3dab6b1-e1d7-44f1-abe3-5b641b7706f8	secret	ZqJULLnNhZJlHfeAG7Q5Eop7fkXbaCyI5FDZKzMTRbz0JWSjKYTYZXYRXU4EVhB92lQ9f_wasBGoaSJv3Poybw
93198245-a841-4a57-b4d1-e7330567babf	b3dab6b1-e1d7-44f1-abe3-5b641b7706f8	algorithm	HS256
01dc3ce8-656c-4cc1-bd2e-45b7e27b35a7	7e27d870-24b0-4e90-9d48-0e6b938b0946	allowed-protocol-mapper-types	saml-user-property-mapper
2867f602-6a72-412d-85a7-275d0b8e087b	7e27d870-24b0-4e90-9d48-0e6b938b0946	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
d1fd2b2d-3098-48d0-afcb-39e103665420	7e27d870-24b0-4e90-9d48-0e6b938b0946	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
1541d4ed-a59d-4813-ba61-55d48b65f2e7	7e27d870-24b0-4e90-9d48-0e6b938b0946	allowed-protocol-mapper-types	oidc-address-mapper
2e2eb4b9-0fab-4390-8684-a1cb320a0858	7e27d870-24b0-4e90-9d48-0e6b938b0946	allowed-protocol-mapper-types	oidc-full-name-mapper
da13145f-a71c-410a-9015-c3b38332bf7b	7e27d870-24b0-4e90-9d48-0e6b938b0946	allowed-protocol-mapper-types	saml-user-attribute-mapper
5e0d1e1f-e16c-403f-bb6b-03bf983effa7	7e27d870-24b0-4e90-9d48-0e6b938b0946	allowed-protocol-mapper-types	saml-role-list-mapper
7237a8ad-5c97-4b84-a650-f88137dc2434	7e27d870-24b0-4e90-9d48-0e6b938b0946	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
92097216-6729-4693-afd5-c76fa424fe3e	e3cf55f4-f4f9-47ed-85fd-2a9a1440b73c	allow-default-scopes	true
7adfcc24-4ddc-4798-972e-96d7d85b36ef	3a9c147c-0343-4fa5-9afd-99bfcf49f3f5	allowed-protocol-mapper-types	saml-user-attribute-mapper
220acc5a-58f3-42cc-8775-4d55959f2664	3a9c147c-0343-4fa5-9afd-99bfcf49f3f5	allowed-protocol-mapper-types	oidc-address-mapper
b59d4614-430c-40a5-b4b5-1b33e1630c13	3a9c147c-0343-4fa5-9afd-99bfcf49f3f5	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
bfb52f24-3079-4a00-9983-de52a02820d4	3a9c147c-0343-4fa5-9afd-99bfcf49f3f5	allowed-protocol-mapper-types	saml-role-list-mapper
f408c35d-3955-46bd-b215-b20e5070c333	3a9c147c-0343-4fa5-9afd-99bfcf49f3f5	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
347b63ff-7b54-474e-999e-6936e9e87400	3a9c147c-0343-4fa5-9afd-99bfcf49f3f5	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
fc71d87e-ddd4-49e4-bbb8-7e48f8d4bbae	3a9c147c-0343-4fa5-9afd-99bfcf49f3f5	allowed-protocol-mapper-types	saml-user-property-mapper
3282dbe8-bd81-449d-a553-daf118abd23e	3a9c147c-0343-4fa5-9afd-99bfcf49f3f5	allowed-protocol-mapper-types	oidc-full-name-mapper
1f41955b-bf7b-4eb6-98fc-c2669e00ca95	df8a1e3e-e952-4e32-be33-ba69dd725bed	client-uris-must-match	true
71871403-6496-4d27-9d18-ad9e24205f72	df8a1e3e-e952-4e32-be33-ba69dd725bed	host-sending-registration-request-must-match	true
1fa523a8-654d-475e-b56a-3d76c9fb8e67	c787e905-4fc0-4a5c-a20c-28b14ce766f3	max-clients	200
358ffde3-30b5-4efe-8220-38119ca7ea4e	9e513644-3419-48bd-b190-7ccdcb3f6690	allow-default-scopes	true
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.composite_role (composite, child_role) FROM stdin;
3e2e8a9e-9261-45a7-9602-aa6957163810	25dff48e-ca4d-4ef1-8328-1b82f4479020
3e2e8a9e-9261-45a7-9602-aa6957163810	4f118403-6624-425a-94e6-7331732fae89
3e2e8a9e-9261-45a7-9602-aa6957163810	7159c1a6-b9fa-42f5-97ae-399fbf792ff5
3e2e8a9e-9261-45a7-9602-aa6957163810	618584c9-da80-4aa9-8393-ec8760d5eda0
3e2e8a9e-9261-45a7-9602-aa6957163810	3baf128a-3164-40bb-884b-fb3fd9a05afc
3e2e8a9e-9261-45a7-9602-aa6957163810	9eb97d24-fb87-47b0-8d8e-fa4c77c53e2e
3e2e8a9e-9261-45a7-9602-aa6957163810	5a804594-69e2-4df3-9109-383e36771b64
3e2e8a9e-9261-45a7-9602-aa6957163810	62ad2562-8a72-4dd0-9159-4d555ad970aa
3e2e8a9e-9261-45a7-9602-aa6957163810	aa184518-4a91-4764-8859-9a991ba38568
3e2e8a9e-9261-45a7-9602-aa6957163810	877930e9-443f-4ffc-a689-558f8a972aee
3e2e8a9e-9261-45a7-9602-aa6957163810	c13dee26-33a8-49d0-b044-5268a7926594
3e2e8a9e-9261-45a7-9602-aa6957163810	b2224c25-972c-4ea4-bc08-aa2038bb6878
3e2e8a9e-9261-45a7-9602-aa6957163810	5f3f70c0-84fb-42dd-839b-71115f81e843
3e2e8a9e-9261-45a7-9602-aa6957163810	fb4be4d7-f611-4e04-960a-6db32414db8d
3e2e8a9e-9261-45a7-9602-aa6957163810	0eb97342-1504-4a4f-b0f6-4b6ea3e11357
3e2e8a9e-9261-45a7-9602-aa6957163810	5fcd96be-3050-455d-9492-7ef67dae9397
3e2e8a9e-9261-45a7-9602-aa6957163810	8fbcc8b9-411f-4efd-ab60-1fb6b495a803
3e2e8a9e-9261-45a7-9602-aa6957163810	88b5faf4-7254-4681-a908-2920d1aff153
3baf128a-3164-40bb-884b-fb3fd9a05afc	5fcd96be-3050-455d-9492-7ef67dae9397
618584c9-da80-4aa9-8393-ec8760d5eda0	88b5faf4-7254-4681-a908-2920d1aff153
618584c9-da80-4aa9-8393-ec8760d5eda0	0eb97342-1504-4a4f-b0f6-4b6ea3e11357
f61fe5ec-00ee-414b-8be3-6acde04f14cf	d8342ca8-be9b-43e9-acd7-2e7398ca8a67
f61fe5ec-00ee-414b-8be3-6acde04f14cf	d6f3d2f8-5843-428d-bb9f-04078ca05b60
d6f3d2f8-5843-428d-bb9f-04078ca05b60	f0980b35-cdca-4d04-8b71-07eef3ed7f3c
5dd6d285-176b-4e12-9648-73cc86f21d5e	c6d845eb-d4f2-49c8-8ea8-13eb97ac2a16
3e2e8a9e-9261-45a7-9602-aa6957163810	59348c55-429d-4d02-b43f-cd50834f9e2e
f61fe5ec-00ee-414b-8be3-6acde04f14cf	90846143-ce86-4f98-8632-40d96c31b2b0
f61fe5ec-00ee-414b-8be3-6acde04f14cf	9b755fab-c36d-4e4f-9478-05dfd37b2606
3e2e8a9e-9261-45a7-9602-aa6957163810	aaf6c4d8-2884-48eb-a46c-9d62015567b2
3e2e8a9e-9261-45a7-9602-aa6957163810	00aefb68-249d-4495-94be-1f9460ceb56e
3e2e8a9e-9261-45a7-9602-aa6957163810	024cb953-1050-4904-8388-96baa0e7265d
3e2e8a9e-9261-45a7-9602-aa6957163810	de93082e-47e6-492b-be51-693b93203fba
3e2e8a9e-9261-45a7-9602-aa6957163810	690efc26-cc7e-4710-8ffc-7d294e467ed8
3e2e8a9e-9261-45a7-9602-aa6957163810	e7fd3e0e-fd83-4489-a07a-94ff3075678c
3e2e8a9e-9261-45a7-9602-aa6957163810	30e7d44b-0582-4b29-b0ec-ffb648e8f04e
3e2e8a9e-9261-45a7-9602-aa6957163810	7efec1ae-d832-419b-a687-90cd1743d5ab
3e2e8a9e-9261-45a7-9602-aa6957163810	e12c3da7-d68e-4a01-93c7-27c8c0233c13
3e2e8a9e-9261-45a7-9602-aa6957163810	411f8639-1bb9-4416-a9c6-cf6ea597f2fe
3e2e8a9e-9261-45a7-9602-aa6957163810	f5c22609-79da-4622-ae21-cfc70ebe6ca8
3e2e8a9e-9261-45a7-9602-aa6957163810	89435dbc-3a75-4e20-b94c-7b6afeacc295
3e2e8a9e-9261-45a7-9602-aa6957163810	b949e0b8-4e09-45ec-acfd-ac2974819983
3e2e8a9e-9261-45a7-9602-aa6957163810	0020f13e-6178-49d5-9abf-e81273aa46f5
3e2e8a9e-9261-45a7-9602-aa6957163810	a5cdc210-391b-43fb-ab15-4e0d096abe8d
3e2e8a9e-9261-45a7-9602-aa6957163810	35be829d-b78c-42d3-8d6e-535c6e5b366e
3e2e8a9e-9261-45a7-9602-aa6957163810	80395774-4ec4-4906-86a5-3c97117cbbaa
de93082e-47e6-492b-be51-693b93203fba	a5cdc210-391b-43fb-ab15-4e0d096abe8d
024cb953-1050-4904-8388-96baa0e7265d	0020f13e-6178-49d5-9abf-e81273aa46f5
024cb953-1050-4904-8388-96baa0e7265d	80395774-4ec4-4906-86a5-3c97117cbbaa
30175b58-23c3-4dfd-8a9b-3df48a47a0e6	1c709c6c-cbb3-4862-a60f-47af1b903897
30175b58-23c3-4dfd-8a9b-3df48a47a0e6	f149d30b-0614-4099-976e-282d86597b80
30175b58-23c3-4dfd-8a9b-3df48a47a0e6	e61d0816-431f-4106-a5e9-882d38374869
30175b58-23c3-4dfd-8a9b-3df48a47a0e6	84aa2f97-f84c-4dc6-9091-b9974e6a3e8a
30175b58-23c3-4dfd-8a9b-3df48a47a0e6	f8ae9479-88db-4c6c-9bee-11edc73a8c14
30175b58-23c3-4dfd-8a9b-3df48a47a0e6	dd8c02d7-b3cf-4b9d-a93e-0f7cac8eca1c
30175b58-23c3-4dfd-8a9b-3df48a47a0e6	e59f327f-0f52-411a-8cf5-97f4d7fde2f3
30175b58-23c3-4dfd-8a9b-3df48a47a0e6	475bb846-3b88-49c6-ba36-55c676cad717
30175b58-23c3-4dfd-8a9b-3df48a47a0e6	cb373132-e2e3-458f-b78f-9f43d590fcda
30175b58-23c3-4dfd-8a9b-3df48a47a0e6	78cade69-3d88-4469-b9a3-c6e7f10f7e76
30175b58-23c3-4dfd-8a9b-3df48a47a0e6	3863d5d4-6f59-47fd-a9a6-34684ad65366
30175b58-23c3-4dfd-8a9b-3df48a47a0e6	4bb41462-6ec1-4eaa-b4ad-fb59da36a66e
30175b58-23c3-4dfd-8a9b-3df48a47a0e6	baca7a59-5c59-4afa-a3a2-5a9961301c0e
30175b58-23c3-4dfd-8a9b-3df48a47a0e6	ee1a6547-7c99-41b6-a560-f08d49e9c4f7
30175b58-23c3-4dfd-8a9b-3df48a47a0e6	c052e142-d9e5-43f8-900a-b3e5f037a659
30175b58-23c3-4dfd-8a9b-3df48a47a0e6	b6a8a783-9b41-4714-bf5a-662a4be9fd97
30175b58-23c3-4dfd-8a9b-3df48a47a0e6	6024cef6-a1ca-438b-ab06-3cd66cca5456
84aa2f97-f84c-4dc6-9091-b9974e6a3e8a	c052e142-d9e5-43f8-900a-b3e5f037a659
e61d0816-431f-4106-a5e9-882d38374869	ee1a6547-7c99-41b6-a560-f08d49e9c4f7
e61d0816-431f-4106-a5e9-882d38374869	6024cef6-a1ca-438b-ab06-3cd66cca5456
70db86dd-42ea-4dbe-a7f9-1752b34f5635	899b73be-7f09-44d2-8557-713ef9764380
70db86dd-42ea-4dbe-a7f9-1752b34f5635	cee77f27-4c66-4321-ac39-e66721c8cc9c
cee77f27-4c66-4321-ac39-e66721c8cc9c	f9d21189-5d06-4196-8f17-104969d58ec7
d34b39d3-142a-4a94-96c0-b17eb6cd5367	98a204e0-b7e2-4dde-81ce-a4314a8797c4
3e2e8a9e-9261-45a7-9602-aa6957163810	cb5dee5d-1e61-4d56-b2e0-8a0d652f93ec
30175b58-23c3-4dfd-8a9b-3df48a47a0e6	70d00eb7-de1d-4393-862a-0904e8163080
70db86dd-42ea-4dbe-a7f9-1752b34f5635	4b2c8957-599d-406c-9956-b4c4d67bd86c
70db86dd-42ea-4dbe-a7f9-1752b34f5635	0800f423-47cc-43a5-a7e4-76a29a9d589a
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
04f37419-c7b5-482b-977a-87273f4ed0ee	\N	password	27259e8e-75ac-4c19-9f28-c306cfa1801c	1620855364699	\N	{"value":"9F2VpVyz3FYUhIX0q/RR4hufpBFPd2r3fTKsydcLCCuNoXSZ+q4r7/CqFVRHUV+m1mjlbm6s5J99ngo6g0cRHg==","salt":"x/AWPf7P+L0hCQSJUHS5dA==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
19cd4e80-40d9-43c4-a184-e207539fe1fc	\N	password	d1ed8b5d-cfa6-493b-92e1-75f63b61bd4a	1620857133654	\N	{"value":"OPQPIi/hJvLomwifoWBtbP4PAqJ5+AKn+syb3Dn+f037FpqqNZc0qCk7hmy0XWFriekeDD40K5mA2gC5DHKGGA==","salt":"fSjvEYmuUW3ui3fcO97Z3Q==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2021-05-12 21:36:00.218717	1	EXECUTED	7:4e70412f24a3f382c82183742ec79317	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	0855360007
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2021-05-12 21:36:00.226413	2	MARK_RAN	7:cb16724583e9675711801c6875114f28	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	0855360007
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2021-05-12 21:36:00.25298	3	EXECUTED	7:0310eb8ba07cec616460794d42ade0fa	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	3.5.4	\N	\N	0855360007
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2021-05-12 21:36:00.258422	4	EXECUTED	7:5d25857e708c3233ef4439df1f93f012	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	0855360007
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2021-05-12 21:36:00.316925	5	EXECUTED	7:c7a54a1041d58eb3817a4a883b4d4e84	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	0855360007
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2021-05-12 21:36:00.319447	6	MARK_RAN	7:2e01012df20974c1c2a605ef8afe25b7	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	0855360007
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2021-05-12 21:36:00.368768	7	EXECUTED	7:0f08df48468428e0f30ee59a8ec01a41	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	0855360007
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2021-05-12 21:36:00.371546	8	MARK_RAN	7:a77ea2ad226b345e7d689d366f185c8c	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	0855360007
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2021-05-12 21:36:00.374568	9	EXECUTED	7:a3377a2059aefbf3b90ebb4c4cc8e2ab	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	3.5.4	\N	\N	0855360007
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2021-05-12 21:36:00.438058	10	EXECUTED	7:04c1dbedc2aa3e9756d1a1668e003451	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	3.5.4	\N	\N	0855360007
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2021-05-12 21:36:00.493764	11	EXECUTED	7:36ef39ed560ad07062d956db861042ba	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	0855360007
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2021-05-12 21:36:00.497905	12	MARK_RAN	7:d909180b2530479a716d3f9c9eaea3d7	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	0855360007
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2021-05-12 21:36:00.511367	13	EXECUTED	7:cf12b04b79bea5152f165eb41f3955f6	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	0855360007
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-05-12 21:36:00.526847	14	EXECUTED	7:7e32c8f05c755e8675764e7d5f514509	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	3.5.4	\N	\N	0855360007
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-05-12 21:36:00.528431	15	MARK_RAN	7:980ba23cc0ec39cab731ce903dd01291	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	0855360007
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-05-12 21:36:00.529899	16	MARK_RAN	7:2fa220758991285312eb84f3b4ff5336	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	3.5.4	\N	\N	0855360007
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-05-12 21:36:00.531214	17	EXECUTED	7:d41d8cd98f00b204e9800998ecf8427e	empty		\N	3.5.4	\N	\N	0855360007
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2021-05-12 21:36:00.557159	18	EXECUTED	7:91ace540896df890cc00a0490ee52bbc	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	3.5.4	\N	\N	0855360007
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2021-05-12 21:36:00.582773	19	EXECUTED	7:c31d1646dfa2618a9335c00e07f89f24	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	0855360007
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2021-05-12 21:36:00.585638	20	EXECUTED	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	0855360007
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-05-12 21:36:01.364092	45	EXECUTED	7:6a48ce645a3525488a90fbf76adf3bb3	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	0855360007
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2021-05-12 21:36:00.587058	21	MARK_RAN	7:f987971fe6b37d963bc95fee2b27f8df	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	0855360007
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2021-05-12 21:36:00.588534	22	MARK_RAN	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	0855360007
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2021-05-12 21:36:00.613445	23	EXECUTED	7:ed2dc7f799d19ac452cbcda56c929e47	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	3.5.4	\N	\N	0855360007
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2021-05-12 21:36:00.616711	24	EXECUTED	7:80b5db88a5dda36ece5f235be8757615	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	0855360007
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2021-05-12 21:36:00.617914	25	MARK_RAN	7:1437310ed1305a9b93f8848f301726ce	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	0855360007
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2021-05-12 21:36:00.755817	26	EXECUTED	7:b82ffb34850fa0836be16deefc6a87c4	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	3.5.4	\N	\N	0855360007
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2021-05-12 21:36:00.811804	27	EXECUTED	7:9cc98082921330d8d9266decdd4bd658	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	3.5.4	\N	\N	0855360007
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2021-05-12 21:36:00.814162	28	EXECUTED	7:03d64aeed9cb52b969bd30a7ac0db57e	update tableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	0855360007
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2021-05-12 21:36:00.863381	29	EXECUTED	7:f1f9fd8710399d725b780f463c6b21cd	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	3.5.4	\N	\N	0855360007
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2021-05-12 21:36:00.874033	30	EXECUTED	7:53188c3eb1107546e6f765835705b6c1	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	3.5.4	\N	\N	0855360007
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2021-05-12 21:36:00.885513	31	EXECUTED	7:d6e6f3bc57a0c5586737d1351725d4d4	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	3.5.4	\N	\N	0855360007
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2021-05-12 21:36:00.888209	32	EXECUTED	7:454d604fbd755d9df3fd9c6329043aa5	customChange		\N	3.5.4	\N	\N	0855360007
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-05-12 21:36:00.891493	33	EXECUTED	7:57e98a3077e29caf562f7dbf80c72600	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	0855360007
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-05-12 21:36:00.892978	34	MARK_RAN	7:e4c7e8f2256210aee71ddc42f538b57a	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	0855360007
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-05-12 21:36:00.909457	35	EXECUTED	7:09a43c97e49bc626460480aa1379b522	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	0855360007
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2021-05-12 21:36:00.912522	36	EXECUTED	7:26bfc7c74fefa9126f2ce702fb775553	addColumn tableName=REALM		\N	3.5.4	\N	\N	0855360007
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-05-12 21:36:00.917456	37	EXECUTED	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	0855360007
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2021-05-12 21:36:00.920185	38	EXECUTED	7:37fc1781855ac5388c494f1442b3f717	addColumn tableName=FED_USER_CONSENT		\N	3.5.4	\N	\N	0855360007
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2021-05-12 21:36:00.922811	39	EXECUTED	7:13a27db0dae6049541136adad7261d27	addColumn tableName=IDENTITY_PROVIDER		\N	3.5.4	\N	\N	0855360007
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2021-05-12 21:36:00.924288	40	MARK_RAN	7:550300617e3b59e8af3a6294df8248a3	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	0855360007
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2021-05-12 21:36:00.925625	41	MARK_RAN	7:e3a9482b8931481dc2772a5c07c44f17	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	0855360007
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2021-05-12 21:36:00.928118	42	EXECUTED	7:72b07d85a2677cb257edb02b408f332d	customChange		\N	3.5.4	\N	\N	0855360007
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2021-05-12 21:36:01.357873	43	EXECUTED	7:a72a7858967bd414835d19e04d880312	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	3.5.4	\N	\N	0855360007
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2021-05-12 21:36:01.361232	44	EXECUTED	7:94edff7cf9ce179e7e85f0cd78a3cf2c	addColumn tableName=USER_ENTITY		\N	3.5.4	\N	\N	0855360007
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-05-12 21:36:01.366733	46	EXECUTED	7:e64b5dcea7db06077c6e57d3b9e5ca14	customChange		\N	3.5.4	\N	\N	0855360007
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-05-12 21:36:01.368101	47	MARK_RAN	7:fd8cf02498f8b1e72496a20afc75178c	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	0855360007
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-05-12 21:36:01.411342	48	EXECUTED	7:542794f25aa2b1fbabb7e577d6646319	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	3.5.4	\N	\N	0855360007
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-05-12 21:36:01.425743	49	EXECUTED	7:edad604c882df12f74941dac3cc6d650	addColumn tableName=REALM		\N	3.5.4	\N	\N	0855360007
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2021-05-12 21:36:01.499847	50	EXECUTED	7:0f88b78b7b46480eb92690cbf5e44900	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	3.5.4	\N	\N	0855360007
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2021-05-12 21:36:01.641504	51	EXECUTED	7:d560e43982611d936457c327f872dd59	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	3.5.4	\N	\N	0855360007
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2021-05-12 21:36:01.644165	52	EXECUTED	7:c155566c42b4d14ef07059ec3b3bbd8e	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	0855360007
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2021-05-12 21:36:01.64602	53	EXECUTED	7:b40376581f12d70f3c89ba8ddf5b7dea	update tableName=REALM		\N	3.5.4	\N	\N	0855360007
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2021-05-12 21:36:01.647948	54	EXECUTED	7:a1132cc395f7b95b3646146c2e38f168	update tableName=CLIENT		\N	3.5.4	\N	\N	0855360007
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-05-12 21:36:01.652994	55	EXECUTED	7:d8dc5d89c789105cfa7ca0e82cba60af	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	3.5.4	\N	\N	0855360007
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-05-12 21:36:01.656219	56	EXECUTED	7:7822e0165097182e8f653c35517656a3	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	3.5.4	\N	\N	0855360007
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-05-12 21:36:01.677542	57	EXECUTED	7:c6538c29b9c9a08f9e9ea2de5c2b6375	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	3.5.4	\N	\N	0855360007
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-05-12 21:36:01.80951	58	EXECUTED	7:6d4893e36de22369cf73bcb051ded875	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	3.5.4	\N	\N	0855360007
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2021-05-12 21:36:01.831167	59	EXECUTED	7:57960fc0b0f0dd0563ea6f8b2e4a1707	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	3.5.4	\N	\N	0855360007
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2021-05-12 21:36:01.835121	60	EXECUTED	7:2b4b8bff39944c7097977cc18dbceb3b	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	0855360007
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2021-05-12 21:36:01.839817	61	EXECUTED	7:2aa42a964c59cd5b8ca9822340ba33a8	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	3.5.4	\N	\N	0855360007
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2021-05-12 21:36:01.844559	62	EXECUTED	7:9ac9e58545479929ba23f4a3087a0346	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	3.5.4	\N	\N	0855360007
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2021-05-12 21:36:01.846907	63	EXECUTED	7:14d407c35bc4fe1976867756bcea0c36	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	0855360007
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2021-05-12 21:36:01.848703	64	EXECUTED	7:241a8030c748c8548e346adee548fa93	update tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	0855360007
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2021-05-12 21:36:01.850394	65	EXECUTED	7:7d3182f65a34fcc61e8d23def037dc3f	update tableName=RESOURCE_SERVER_RESOURCE		\N	3.5.4	\N	\N	0855360007
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2021-05-12 21:36:01.867272	66	EXECUTED	7:b30039e00a0b9715d430d1b0636728fa	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	3.5.4	\N	\N	0855360007
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2021-05-12 21:36:01.877246	67	EXECUTED	7:3797315ca61d531780f8e6f82f258159	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	3.5.4	\N	\N	0855360007
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2021-05-12 21:36:01.880581	68	EXECUTED	7:c7aa4c8d9573500c2d347c1941ff0301	addColumn tableName=REALM		\N	3.5.4	\N	\N	0855360007
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2021-05-12 21:36:01.892421	69	EXECUTED	7:b207faee394fc074a442ecd42185a5dd	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	3.5.4	\N	\N	0855360007
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2021-05-12 21:36:01.895509	70	EXECUTED	7:ab9a9762faaba4ddfa35514b212c4922	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	3.5.4	\N	\N	0855360007
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2021-05-12 21:36:01.898158	71	EXECUTED	7:b9710f74515a6ccb51b72dc0d19df8c4	addColumn tableName=RESOURCE_SERVER		\N	3.5.4	\N	\N	0855360007
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-05-12 21:36:01.902134	72	EXECUTED	7:ec9707ae4d4f0b7452fee20128083879	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	0855360007
8.0.0-updating-credential-data-not-oracle	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-05-12 21:36:01.904987	73	EXECUTED	7:03b3f4b264c3c68ba082250a80b74216	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	0855360007
8.0.0-updating-credential-data-oracle	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-05-12 21:36:01.906231	74	MARK_RAN	7:64c5728f5ca1f5aa4392217701c4fe23	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	0855360007
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-05-12 21:36:01.913754	75	EXECUTED	7:b48da8c11a3d83ddd6b7d0c8c2219345	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	3.5.4	\N	\N	0855360007
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-05-12 21:36:01.924596	76	EXECUTED	7:a73379915c23bfad3e8f5c6d5c0aa4bd	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	3.5.4	\N	\N	0855360007
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-05-12 21:36:01.927265	77	EXECUTED	7:39e0073779aba192646291aa2332493d	addColumn tableName=CLIENT		\N	3.5.4	\N	\N	0855360007
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-05-12 21:36:01.928725	78	MARK_RAN	7:81f87368f00450799b4bf42ea0b3ec34	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	3.5.4	\N	\N	0855360007
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-05-12 21:36:01.940109	79	EXECUTED	7:20b37422abb9fb6571c618148f013a15	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	3.5.4	\N	\N	0855360007
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-05-12 21:36:01.941613	80	MARK_RAN	7:1970bb6cfb5ee800736b95ad3fb3c78a	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	3.5.4	\N	\N	0855360007
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-05-12 21:36:01.951914	81	EXECUTED	7:45d9b25fc3b455d522d8dcc10a0f4c80	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	3.5.4	\N	\N	0855360007
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-05-12 21:36:01.953213	82	MARK_RAN	7:890ae73712bc187a66c2813a724d037f	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	0855360007
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-05-12 21:36:01.955559	83	EXECUTED	7:0a211980d27fafe3ff50d19a3a29b538	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	0855360007
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-05-12 21:36:01.956785	84	MARK_RAN	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	0855360007
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-05-12 21:36:01.966801	85	EXECUTED	7:01c49302201bdf815b0a18d1f98a55dc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	0855360007
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2021-05-12 21:36:01.969982	86	EXECUTED	7:3dace6b144c11f53f1ad2c0361279b86	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	3.5.4	\N	\N	0855360007
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2021-05-12 21:36:01.97397	87	EXECUTED	7:578d0b92077eaf2ab95ad0ec087aa903	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	3.5.4	\N	\N	0855360007
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2021-05-12 21:36:01.980947	88	EXECUTED	7:c95abe90d962c57a09ecaee57972835d	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	3.5.4	\N	\N	0855360007
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-05-12 21:36:01.984204	89	EXECUTED	7:f1313bcc2994a5c4dc1062ed6d8282d3	addColumn tableName=REALM; customChange		\N	3.5.4	\N	\N	0855360007
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-05-12 21:36:01.987695	90	EXECUTED	7:90d763b52eaffebefbcbde55f269508b	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	3.5.4	\N	\N	0855360007
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-05-12 21:36:02.004963	91	EXECUTED	7:d554f0cb92b764470dccfa5e0014a7dd	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	0855360007
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-05-12 21:36:02.009382	92	EXECUTED	7:73193e3ab3c35cf0f37ccea3bf783764	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	3.5.4	\N	\N	0855360007
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-05-12 21:36:02.010695	93	MARK_RAN	7:90a1e74f92e9cbaa0c5eab80b8a037f3	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	3.5.4	\N	\N	0855360007
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-05-12 21:36:02.017029	94	EXECUTED	7:5b9248f29cd047c200083cc6d8388b16	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	3.5.4	\N	\N	0855360007
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-05-12 21:36:02.018469	95	MARK_RAN	7:64db59e44c374f13955489e8990d17a1	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	3.5.4	\N	\N	0855360007
json-string-accomodation	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-05-12 21:36:02.023142	96	EXECUTED	7:00e92c604b019717c8db9946ddc85af4	addColumn tableName=REALM_ATTRIBUTE; sql; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	3.5.4	\N	\N	0855360007
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
master	9cb3863a-5fcb-4477-a6b9-538e1d585843	f
master	71086583-60cd-4512-841a-992363b4529e	t
master	f5842f03-8ba4-4f78-8532-c5d702c08f57	t
master	8746d31f-0308-4fad-b1fb-28aa452be4df	t
master	bb0208e9-7a10-4953-992e-3b7ac9aaa24a	f
master	f0614f6b-7fbc-4c9d-9f17-a315afa0d0f7	f
master	c04562a0-ca6e-442c-b2e0-2bdb170d57e2	t
master	bfdc4612-6573-476d-9108-bf6f94fe52c6	t
master	3edd4bad-a96b-49f2-a47a-3dffe24e7613	f
pkb-fhir	19515007-dd24-461d-aeaa-f8f050b2bf48	f
pkb-fhir	939796f2-cff0-4672-8835-01b221e8610a	t
pkb-fhir	e44e2e32-86dd-43b5-abdc-8f0aac0b1878	t
pkb-fhir	dca024ab-f75f-4254-852c-ef9ac1689786	t
pkb-fhir	a8ca61dd-f593-41b4-95fe-aefa18d440a2	f
pkb-fhir	2005b049-0070-4d70-85dc-7c36f79223f2	f
pkb-fhir	7a8ced8c-d7c4-490d-b8a9-fb678e937992	t
pkb-fhir	a8871684-4222-4538-9574-a8dd09ae7d2a	t
pkb-fhir	a7695dab-7607-4f28-a76e-d7995b7a8fcd	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
f61fe5ec-00ee-414b-8be3-6acde04f14cf	master	f	${role_default-roles}	default-roles-master	master	\N	\N
3e2e8a9e-9261-45a7-9602-aa6957163810	master	f	${role_admin}	admin	master	\N	\N
25dff48e-ca4d-4ef1-8328-1b82f4479020	master	f	${role_create-realm}	create-realm	master	\N	\N
4f118403-6624-425a-94e6-7331732fae89	57aed360-afb0-44a1-b480-f2b6f74bdab4	t	${role_create-client}	create-client	master	57aed360-afb0-44a1-b480-f2b6f74bdab4	\N
7159c1a6-b9fa-42f5-97ae-399fbf792ff5	57aed360-afb0-44a1-b480-f2b6f74bdab4	t	${role_view-realm}	view-realm	master	57aed360-afb0-44a1-b480-f2b6f74bdab4	\N
618584c9-da80-4aa9-8393-ec8760d5eda0	57aed360-afb0-44a1-b480-f2b6f74bdab4	t	${role_view-users}	view-users	master	57aed360-afb0-44a1-b480-f2b6f74bdab4	\N
3baf128a-3164-40bb-884b-fb3fd9a05afc	57aed360-afb0-44a1-b480-f2b6f74bdab4	t	${role_view-clients}	view-clients	master	57aed360-afb0-44a1-b480-f2b6f74bdab4	\N
9eb97d24-fb87-47b0-8d8e-fa4c77c53e2e	57aed360-afb0-44a1-b480-f2b6f74bdab4	t	${role_view-events}	view-events	master	57aed360-afb0-44a1-b480-f2b6f74bdab4	\N
5a804594-69e2-4df3-9109-383e36771b64	57aed360-afb0-44a1-b480-f2b6f74bdab4	t	${role_view-identity-providers}	view-identity-providers	master	57aed360-afb0-44a1-b480-f2b6f74bdab4	\N
62ad2562-8a72-4dd0-9159-4d555ad970aa	57aed360-afb0-44a1-b480-f2b6f74bdab4	t	${role_view-authorization}	view-authorization	master	57aed360-afb0-44a1-b480-f2b6f74bdab4	\N
aa184518-4a91-4764-8859-9a991ba38568	57aed360-afb0-44a1-b480-f2b6f74bdab4	t	${role_manage-realm}	manage-realm	master	57aed360-afb0-44a1-b480-f2b6f74bdab4	\N
877930e9-443f-4ffc-a689-558f8a972aee	57aed360-afb0-44a1-b480-f2b6f74bdab4	t	${role_manage-users}	manage-users	master	57aed360-afb0-44a1-b480-f2b6f74bdab4	\N
c13dee26-33a8-49d0-b044-5268a7926594	57aed360-afb0-44a1-b480-f2b6f74bdab4	t	${role_manage-clients}	manage-clients	master	57aed360-afb0-44a1-b480-f2b6f74bdab4	\N
b2224c25-972c-4ea4-bc08-aa2038bb6878	57aed360-afb0-44a1-b480-f2b6f74bdab4	t	${role_manage-events}	manage-events	master	57aed360-afb0-44a1-b480-f2b6f74bdab4	\N
5f3f70c0-84fb-42dd-839b-71115f81e843	57aed360-afb0-44a1-b480-f2b6f74bdab4	t	${role_manage-identity-providers}	manage-identity-providers	master	57aed360-afb0-44a1-b480-f2b6f74bdab4	\N
fb4be4d7-f611-4e04-960a-6db32414db8d	57aed360-afb0-44a1-b480-f2b6f74bdab4	t	${role_manage-authorization}	manage-authorization	master	57aed360-afb0-44a1-b480-f2b6f74bdab4	\N
0eb97342-1504-4a4f-b0f6-4b6ea3e11357	57aed360-afb0-44a1-b480-f2b6f74bdab4	t	${role_query-users}	query-users	master	57aed360-afb0-44a1-b480-f2b6f74bdab4	\N
5fcd96be-3050-455d-9492-7ef67dae9397	57aed360-afb0-44a1-b480-f2b6f74bdab4	t	${role_query-clients}	query-clients	master	57aed360-afb0-44a1-b480-f2b6f74bdab4	\N
8fbcc8b9-411f-4efd-ab60-1fb6b495a803	57aed360-afb0-44a1-b480-f2b6f74bdab4	t	${role_query-realms}	query-realms	master	57aed360-afb0-44a1-b480-f2b6f74bdab4	\N
88b5faf4-7254-4681-a908-2920d1aff153	57aed360-afb0-44a1-b480-f2b6f74bdab4	t	${role_query-groups}	query-groups	master	57aed360-afb0-44a1-b480-f2b6f74bdab4	\N
d8342ca8-be9b-43e9-acd7-2e7398ca8a67	b4a9b818-2099-4d12-bfae-867f5ce288b3	t	${role_view-profile}	view-profile	master	b4a9b818-2099-4d12-bfae-867f5ce288b3	\N
d6f3d2f8-5843-428d-bb9f-04078ca05b60	b4a9b818-2099-4d12-bfae-867f5ce288b3	t	${role_manage-account}	manage-account	master	b4a9b818-2099-4d12-bfae-867f5ce288b3	\N
f0980b35-cdca-4d04-8b71-07eef3ed7f3c	b4a9b818-2099-4d12-bfae-867f5ce288b3	t	${role_manage-account-links}	manage-account-links	master	b4a9b818-2099-4d12-bfae-867f5ce288b3	\N
071e56b7-b63e-4e53-8f28-dd7c27a7002f	b4a9b818-2099-4d12-bfae-867f5ce288b3	t	${role_view-applications}	view-applications	master	b4a9b818-2099-4d12-bfae-867f5ce288b3	\N
c6d845eb-d4f2-49c8-8ea8-13eb97ac2a16	b4a9b818-2099-4d12-bfae-867f5ce288b3	t	${role_view-consent}	view-consent	master	b4a9b818-2099-4d12-bfae-867f5ce288b3	\N
5dd6d285-176b-4e12-9648-73cc86f21d5e	b4a9b818-2099-4d12-bfae-867f5ce288b3	t	${role_manage-consent}	manage-consent	master	b4a9b818-2099-4d12-bfae-867f5ce288b3	\N
10bf8553-6d00-47b7-aef4-2df8bcffea0d	b4a9b818-2099-4d12-bfae-867f5ce288b3	t	${role_delete-account}	delete-account	master	b4a9b818-2099-4d12-bfae-867f5ce288b3	\N
79a16180-c7de-4886-afe3-4ae0f4407add	5e06b450-a41d-4d8b-8ffc-3a1b5ec2fc42	t	${role_read-token}	read-token	master	5e06b450-a41d-4d8b-8ffc-3a1b5ec2fc42	\N
59348c55-429d-4d02-b43f-cd50834f9e2e	57aed360-afb0-44a1-b480-f2b6f74bdab4	t	${role_impersonation}	impersonation	master	57aed360-afb0-44a1-b480-f2b6f74bdab4	\N
90846143-ce86-4f98-8632-40d96c31b2b0	master	f	${role_offline-access}	offline_access	master	\N	\N
9b755fab-c36d-4e4f-9478-05dfd37b2606	master	f	${role_uma_authorization}	uma_authorization	master	\N	\N
70db86dd-42ea-4dbe-a7f9-1752b34f5635	pkb-fhir	f	${role_default-roles}	default-roles-pkb-fhir	pkb-fhir	\N	\N
aaf6c4d8-2884-48eb-a46c-9d62015567b2	e7b4b8cc-790e-48fd-858c-bc5fffabeb41	t	${role_create-client}	create-client	master	e7b4b8cc-790e-48fd-858c-bc5fffabeb41	\N
00aefb68-249d-4495-94be-1f9460ceb56e	e7b4b8cc-790e-48fd-858c-bc5fffabeb41	t	${role_view-realm}	view-realm	master	e7b4b8cc-790e-48fd-858c-bc5fffabeb41	\N
024cb953-1050-4904-8388-96baa0e7265d	e7b4b8cc-790e-48fd-858c-bc5fffabeb41	t	${role_view-users}	view-users	master	e7b4b8cc-790e-48fd-858c-bc5fffabeb41	\N
de93082e-47e6-492b-be51-693b93203fba	e7b4b8cc-790e-48fd-858c-bc5fffabeb41	t	${role_view-clients}	view-clients	master	e7b4b8cc-790e-48fd-858c-bc5fffabeb41	\N
690efc26-cc7e-4710-8ffc-7d294e467ed8	e7b4b8cc-790e-48fd-858c-bc5fffabeb41	t	${role_view-events}	view-events	master	e7b4b8cc-790e-48fd-858c-bc5fffabeb41	\N
e7fd3e0e-fd83-4489-a07a-94ff3075678c	e7b4b8cc-790e-48fd-858c-bc5fffabeb41	t	${role_view-identity-providers}	view-identity-providers	master	e7b4b8cc-790e-48fd-858c-bc5fffabeb41	\N
30e7d44b-0582-4b29-b0ec-ffb648e8f04e	e7b4b8cc-790e-48fd-858c-bc5fffabeb41	t	${role_view-authorization}	view-authorization	master	e7b4b8cc-790e-48fd-858c-bc5fffabeb41	\N
7efec1ae-d832-419b-a687-90cd1743d5ab	e7b4b8cc-790e-48fd-858c-bc5fffabeb41	t	${role_manage-realm}	manage-realm	master	e7b4b8cc-790e-48fd-858c-bc5fffabeb41	\N
e12c3da7-d68e-4a01-93c7-27c8c0233c13	e7b4b8cc-790e-48fd-858c-bc5fffabeb41	t	${role_manage-users}	manage-users	master	e7b4b8cc-790e-48fd-858c-bc5fffabeb41	\N
411f8639-1bb9-4416-a9c6-cf6ea597f2fe	e7b4b8cc-790e-48fd-858c-bc5fffabeb41	t	${role_manage-clients}	manage-clients	master	e7b4b8cc-790e-48fd-858c-bc5fffabeb41	\N
f5c22609-79da-4622-ae21-cfc70ebe6ca8	e7b4b8cc-790e-48fd-858c-bc5fffabeb41	t	${role_manage-events}	manage-events	master	e7b4b8cc-790e-48fd-858c-bc5fffabeb41	\N
89435dbc-3a75-4e20-b94c-7b6afeacc295	e7b4b8cc-790e-48fd-858c-bc5fffabeb41	t	${role_manage-identity-providers}	manage-identity-providers	master	e7b4b8cc-790e-48fd-858c-bc5fffabeb41	\N
b949e0b8-4e09-45ec-acfd-ac2974819983	e7b4b8cc-790e-48fd-858c-bc5fffabeb41	t	${role_manage-authorization}	manage-authorization	master	e7b4b8cc-790e-48fd-858c-bc5fffabeb41	\N
0020f13e-6178-49d5-9abf-e81273aa46f5	e7b4b8cc-790e-48fd-858c-bc5fffabeb41	t	${role_query-users}	query-users	master	e7b4b8cc-790e-48fd-858c-bc5fffabeb41	\N
a5cdc210-391b-43fb-ab15-4e0d096abe8d	e7b4b8cc-790e-48fd-858c-bc5fffabeb41	t	${role_query-clients}	query-clients	master	e7b4b8cc-790e-48fd-858c-bc5fffabeb41	\N
35be829d-b78c-42d3-8d6e-535c6e5b366e	e7b4b8cc-790e-48fd-858c-bc5fffabeb41	t	${role_query-realms}	query-realms	master	e7b4b8cc-790e-48fd-858c-bc5fffabeb41	\N
80395774-4ec4-4906-86a5-3c97117cbbaa	e7b4b8cc-790e-48fd-858c-bc5fffabeb41	t	${role_query-groups}	query-groups	master	e7b4b8cc-790e-48fd-858c-bc5fffabeb41	\N
30175b58-23c3-4dfd-8a9b-3df48a47a0e6	fb21d241-3368-4331-8d58-5160a53744ee	t	${role_realm-admin}	realm-admin	pkb-fhir	fb21d241-3368-4331-8d58-5160a53744ee	\N
1c709c6c-cbb3-4862-a60f-47af1b903897	fb21d241-3368-4331-8d58-5160a53744ee	t	${role_create-client}	create-client	pkb-fhir	fb21d241-3368-4331-8d58-5160a53744ee	\N
f149d30b-0614-4099-976e-282d86597b80	fb21d241-3368-4331-8d58-5160a53744ee	t	${role_view-realm}	view-realm	pkb-fhir	fb21d241-3368-4331-8d58-5160a53744ee	\N
e61d0816-431f-4106-a5e9-882d38374869	fb21d241-3368-4331-8d58-5160a53744ee	t	${role_view-users}	view-users	pkb-fhir	fb21d241-3368-4331-8d58-5160a53744ee	\N
84aa2f97-f84c-4dc6-9091-b9974e6a3e8a	fb21d241-3368-4331-8d58-5160a53744ee	t	${role_view-clients}	view-clients	pkb-fhir	fb21d241-3368-4331-8d58-5160a53744ee	\N
f8ae9479-88db-4c6c-9bee-11edc73a8c14	fb21d241-3368-4331-8d58-5160a53744ee	t	${role_view-events}	view-events	pkb-fhir	fb21d241-3368-4331-8d58-5160a53744ee	\N
dd8c02d7-b3cf-4b9d-a93e-0f7cac8eca1c	fb21d241-3368-4331-8d58-5160a53744ee	t	${role_view-identity-providers}	view-identity-providers	pkb-fhir	fb21d241-3368-4331-8d58-5160a53744ee	\N
e59f327f-0f52-411a-8cf5-97f4d7fde2f3	fb21d241-3368-4331-8d58-5160a53744ee	t	${role_view-authorization}	view-authorization	pkb-fhir	fb21d241-3368-4331-8d58-5160a53744ee	\N
475bb846-3b88-49c6-ba36-55c676cad717	fb21d241-3368-4331-8d58-5160a53744ee	t	${role_manage-realm}	manage-realm	pkb-fhir	fb21d241-3368-4331-8d58-5160a53744ee	\N
cb373132-e2e3-458f-b78f-9f43d590fcda	fb21d241-3368-4331-8d58-5160a53744ee	t	${role_manage-users}	manage-users	pkb-fhir	fb21d241-3368-4331-8d58-5160a53744ee	\N
78cade69-3d88-4469-b9a3-c6e7f10f7e76	fb21d241-3368-4331-8d58-5160a53744ee	t	${role_manage-clients}	manage-clients	pkb-fhir	fb21d241-3368-4331-8d58-5160a53744ee	\N
3863d5d4-6f59-47fd-a9a6-34684ad65366	fb21d241-3368-4331-8d58-5160a53744ee	t	${role_manage-events}	manage-events	pkb-fhir	fb21d241-3368-4331-8d58-5160a53744ee	\N
4bb41462-6ec1-4eaa-b4ad-fb59da36a66e	fb21d241-3368-4331-8d58-5160a53744ee	t	${role_manage-identity-providers}	manage-identity-providers	pkb-fhir	fb21d241-3368-4331-8d58-5160a53744ee	\N
baca7a59-5c59-4afa-a3a2-5a9961301c0e	fb21d241-3368-4331-8d58-5160a53744ee	t	${role_manage-authorization}	manage-authorization	pkb-fhir	fb21d241-3368-4331-8d58-5160a53744ee	\N
ee1a6547-7c99-41b6-a560-f08d49e9c4f7	fb21d241-3368-4331-8d58-5160a53744ee	t	${role_query-users}	query-users	pkb-fhir	fb21d241-3368-4331-8d58-5160a53744ee	\N
c052e142-d9e5-43f8-900a-b3e5f037a659	fb21d241-3368-4331-8d58-5160a53744ee	t	${role_query-clients}	query-clients	pkb-fhir	fb21d241-3368-4331-8d58-5160a53744ee	\N
b6a8a783-9b41-4714-bf5a-662a4be9fd97	fb21d241-3368-4331-8d58-5160a53744ee	t	${role_query-realms}	query-realms	pkb-fhir	fb21d241-3368-4331-8d58-5160a53744ee	\N
6024cef6-a1ca-438b-ab06-3cd66cca5456	fb21d241-3368-4331-8d58-5160a53744ee	t	${role_query-groups}	query-groups	pkb-fhir	fb21d241-3368-4331-8d58-5160a53744ee	\N
899b73be-7f09-44d2-8557-713ef9764380	9829268b-9da1-4fd0-a953-9078144d2774	t	${role_view-profile}	view-profile	pkb-fhir	9829268b-9da1-4fd0-a953-9078144d2774	\N
cee77f27-4c66-4321-ac39-e66721c8cc9c	9829268b-9da1-4fd0-a953-9078144d2774	t	${role_manage-account}	manage-account	pkb-fhir	9829268b-9da1-4fd0-a953-9078144d2774	\N
f9d21189-5d06-4196-8f17-104969d58ec7	9829268b-9da1-4fd0-a953-9078144d2774	t	${role_manage-account-links}	manage-account-links	pkb-fhir	9829268b-9da1-4fd0-a953-9078144d2774	\N
11ac00cb-8fd3-426f-9180-cdb628ea50b7	9829268b-9da1-4fd0-a953-9078144d2774	t	${role_view-applications}	view-applications	pkb-fhir	9829268b-9da1-4fd0-a953-9078144d2774	\N
98a204e0-b7e2-4dde-81ce-a4314a8797c4	9829268b-9da1-4fd0-a953-9078144d2774	t	${role_view-consent}	view-consent	pkb-fhir	9829268b-9da1-4fd0-a953-9078144d2774	\N
d34b39d3-142a-4a94-96c0-b17eb6cd5367	9829268b-9da1-4fd0-a953-9078144d2774	t	${role_manage-consent}	manage-consent	pkb-fhir	9829268b-9da1-4fd0-a953-9078144d2774	\N
cb55ec8c-f1f9-473f-bec4-d59ea01b522e	9829268b-9da1-4fd0-a953-9078144d2774	t	${role_delete-account}	delete-account	pkb-fhir	9829268b-9da1-4fd0-a953-9078144d2774	\N
cb5dee5d-1e61-4d56-b2e0-8a0d652f93ec	e7b4b8cc-790e-48fd-858c-bc5fffabeb41	t	${role_impersonation}	impersonation	master	e7b4b8cc-790e-48fd-858c-bc5fffabeb41	\N
70d00eb7-de1d-4393-862a-0904e8163080	fb21d241-3368-4331-8d58-5160a53744ee	t	${role_impersonation}	impersonation	pkb-fhir	fb21d241-3368-4331-8d58-5160a53744ee	\N
0afd3f23-835b-4748-bc68-7342d42aeddb	68fdd712-9c7b-4e78-a445-24332f8c65e1	t	${role_read-token}	read-token	pkb-fhir	68fdd712-9c7b-4e78-a445-24332f8c65e1	\N
4b2c8957-599d-406c-9956-b4c4d67bd86c	pkb-fhir	f	${role_offline-access}	offline_access	pkb-fhir	\N	\N
0800f423-47cc-43a5-a7e4-76a29a9d589a	pkb-fhir	f	${role_uma_authorization}	uma_authorization	pkb-fhir	\N	\N
6cc5403e-3e1b-4135-9d40-f9469e04b246	f18864b2-c169-4a00-acd7-dc790bd2cd6e	t	\N	uma_protection	pkb-fhir	f18864b2-c169-4a00-acd7-dc790bd2cd6e	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.migration_model (id, version, update_time) FROM stdin;
bkuhm	13.0.0	1620855363
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
e44ec5cd-faaf-4c78-97d1-b31e4e51714e	audience resolve	openid-connect	oidc-audience-resolve-mapper	12ddecff-fe86-4fec-9e67-fd3db715f772	\N
64501e79-c703-46fc-b6f2-f29ebd5c44c6	locale	openid-connect	oidc-usermodel-attribute-mapper	0d2f3cc8-e788-4558-be62-c06c1581a14d	\N
c98e48f5-716c-4711-9b40-3cf881295698	role list	saml	saml-role-list-mapper	\N	71086583-60cd-4512-841a-992363b4529e
152801aa-61e5-4f4a-ae86-4d9e8260ddec	full name	openid-connect	oidc-full-name-mapper	\N	f5842f03-8ba4-4f78-8532-c5d702c08f57
0815f9ac-2722-460e-9d04-334ef92937ea	family name	openid-connect	oidc-usermodel-property-mapper	\N	f5842f03-8ba4-4f78-8532-c5d702c08f57
6074127e-ac77-4ba4-9382-065227b9a69b	given name	openid-connect	oidc-usermodel-property-mapper	\N	f5842f03-8ba4-4f78-8532-c5d702c08f57
56c9d7ae-4d17-41a6-86a0-53f5708dde12	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	f5842f03-8ba4-4f78-8532-c5d702c08f57
c7d4d3c7-abe9-4069-8caf-21d56a3ed9d2	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	f5842f03-8ba4-4f78-8532-c5d702c08f57
93b49089-b5dd-4d7a-91b2-e49092fa1bc5	username	openid-connect	oidc-usermodel-property-mapper	\N	f5842f03-8ba4-4f78-8532-c5d702c08f57
0bd1d990-a338-4858-9bc7-7daac719a0b3	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	f5842f03-8ba4-4f78-8532-c5d702c08f57
7569db26-91cf-405f-aa5a-9bf2006eee95	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	f5842f03-8ba4-4f78-8532-c5d702c08f57
7f2ec6d7-daf1-414d-97ac-234fefc8ed63	website	openid-connect	oidc-usermodel-attribute-mapper	\N	f5842f03-8ba4-4f78-8532-c5d702c08f57
b9490d21-3d4f-43f4-8823-fb3b406416c6	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	f5842f03-8ba4-4f78-8532-c5d702c08f57
ffdbe25b-9edb-4e7f-aa1c-1db717534e8d	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	f5842f03-8ba4-4f78-8532-c5d702c08f57
8dd176f2-3af4-434a-80cd-19064744ce81	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	f5842f03-8ba4-4f78-8532-c5d702c08f57
ef0181a7-ba17-43a4-82ca-7abc8bdf4548	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	f5842f03-8ba4-4f78-8532-c5d702c08f57
aad3d7fb-9383-4d8a-a5cc-0d00b04943eb	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	f5842f03-8ba4-4f78-8532-c5d702c08f57
1479d6bd-db18-475e-ac52-6d6f14ae425e	email	openid-connect	oidc-usermodel-property-mapper	\N	8746d31f-0308-4fad-b1fb-28aa452be4df
4a6bdadf-e0c4-44c5-8493-05c5f07f6bda	email verified	openid-connect	oidc-usermodel-property-mapper	\N	8746d31f-0308-4fad-b1fb-28aa452be4df
7d0ac5a9-4c4d-4d09-8640-eb99abafd18f	address	openid-connect	oidc-address-mapper	\N	bb0208e9-7a10-4953-992e-3b7ac9aaa24a
37f5a9fa-a948-4145-b15d-3c8279aa6a8d	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	f0614f6b-7fbc-4c9d-9f17-a315afa0d0f7
6e301a78-39db-488b-9462-992c833153ed	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	f0614f6b-7fbc-4c9d-9f17-a315afa0d0f7
d56883b1-022d-4d2d-bd51-917b3b12a1df	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	c04562a0-ca6e-442c-b2e0-2bdb170d57e2
20379d9f-9a5b-42a3-8145-171f81c2d058	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	c04562a0-ca6e-442c-b2e0-2bdb170d57e2
f84d6c6d-68b9-4495-a820-a345d0f695fd	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	c04562a0-ca6e-442c-b2e0-2bdb170d57e2
b276c494-4eb1-4329-9053-843a0f6d79a4	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	bfdc4612-6573-476d-9108-bf6f94fe52c6
6359935c-3ee3-44c8-a3d0-893e8746e512	upn	openid-connect	oidc-usermodel-property-mapper	\N	3edd4bad-a96b-49f2-a47a-3dffe24e7613
d30b401f-8640-4855-816d-4dc3f95b2399	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	3edd4bad-a96b-49f2-a47a-3dffe24e7613
3d57e90c-8abc-4f58-aaa1-a75013f7a4ef	audience resolve	openid-connect	oidc-audience-resolve-mapper	57b71758-9d62-4c0f-9b02-7ae1201e81a3	\N
131cba59-41eb-4b7b-9eb1-54b8def1d4da	role list	saml	saml-role-list-mapper	\N	939796f2-cff0-4672-8835-01b221e8610a
e2bbda4f-2d60-49e2-a95c-576b357a51a1	full name	openid-connect	oidc-full-name-mapper	\N	e44e2e32-86dd-43b5-abdc-8f0aac0b1878
da1fb1c4-a9ee-4ac3-8342-5ef5645b51ab	family name	openid-connect	oidc-usermodel-property-mapper	\N	e44e2e32-86dd-43b5-abdc-8f0aac0b1878
71d7e065-d421-4066-9f75-133acb8ee141	given name	openid-connect	oidc-usermodel-property-mapper	\N	e44e2e32-86dd-43b5-abdc-8f0aac0b1878
982c2114-b1f0-435b-97c0-0737bfcd3b96	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	e44e2e32-86dd-43b5-abdc-8f0aac0b1878
df21aad5-2cd7-420e-9758-71ae199445f3	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	e44e2e32-86dd-43b5-abdc-8f0aac0b1878
11414972-f6d2-45cf-815d-7fd721c305d4	username	openid-connect	oidc-usermodel-property-mapper	\N	e44e2e32-86dd-43b5-abdc-8f0aac0b1878
3c98a78b-024a-478d-9f49-aca518a68c6d	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	e44e2e32-86dd-43b5-abdc-8f0aac0b1878
3f43702c-ab36-49d1-b062-779c030854d5	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	e44e2e32-86dd-43b5-abdc-8f0aac0b1878
bbd1ab2a-fb05-47e8-b418-102f4e160d9d	website	openid-connect	oidc-usermodel-attribute-mapper	\N	e44e2e32-86dd-43b5-abdc-8f0aac0b1878
613fbc7d-f3f9-4403-a2f1-f55857e8b568	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	e44e2e32-86dd-43b5-abdc-8f0aac0b1878
c4918db1-03d0-427f-9982-955a57fa5957	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	e44e2e32-86dd-43b5-abdc-8f0aac0b1878
604e75ab-0a9a-47f8-b2cd-9e1100117710	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	e44e2e32-86dd-43b5-abdc-8f0aac0b1878
adc06ad8-0ef3-4c4a-a6c8-8b72af7b0dc8	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	e44e2e32-86dd-43b5-abdc-8f0aac0b1878
71314d62-c7fa-4893-ad6f-794c3a399dc1	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	e44e2e32-86dd-43b5-abdc-8f0aac0b1878
995880c9-68d4-47b5-83b0-47bc1921dc79	email	openid-connect	oidc-usermodel-property-mapper	\N	dca024ab-f75f-4254-852c-ef9ac1689786
98626b8b-8fe0-408c-9015-d3fa38544f24	email verified	openid-connect	oidc-usermodel-property-mapper	\N	dca024ab-f75f-4254-852c-ef9ac1689786
3fd3ba54-72d3-483f-a508-657e179d0174	address	openid-connect	oidc-address-mapper	\N	a8ca61dd-f593-41b4-95fe-aefa18d440a2
08722b7d-e639-4e83-aad0-d8ca2ecfc9ae	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	2005b049-0070-4d70-85dc-7c36f79223f2
36fc92f2-b408-4a66-8194-4341f7727e90	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	2005b049-0070-4d70-85dc-7c36f79223f2
073f6f50-5b50-4939-94b4-b1f315ee2f69	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	7a8ced8c-d7c4-490d-b8a9-fb678e937992
0c0b9b6f-7e15-4f69-9f2c-498a714a2880	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	7a8ced8c-d7c4-490d-b8a9-fb678e937992
c9568f1d-7cd5-4ade-be4a-3d20d652bfc3	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	7a8ced8c-d7c4-490d-b8a9-fb678e937992
fdba72fb-8d06-4337-b871-d8c08636577b	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	a8871684-4222-4538-9574-a8dd09ae7d2a
e45dc056-c4d8-4df5-b8fc-7979b147f271	upn	openid-connect	oidc-usermodel-property-mapper	\N	a7695dab-7607-4f28-a76e-d7995b7a8fcd
fc4c7a00-bdce-4026-966b-e8e38d38cb28	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	a7695dab-7607-4f28-a76e-d7995b7a8fcd
f6b7b9ac-bb63-46c2-96d2-805b1f36c38a	locale	openid-connect	oidc-usermodel-attribute-mapper	2496af99-dc8b-4bad-afea-9c1be3d8c437	\N
4e7c74aa-14e5-434d-9b20-633ab35910c2	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	f18864b2-c169-4a00-acd7-dc790bd2cd6e	\N
74c225e9-6716-46f2-af65-aab928f2e7af	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	f18864b2-c169-4a00-acd7-dc790bd2cd6e	\N
3362bb26-34e5-42de-861c-40011a820ce6	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	f18864b2-c169-4a00-acd7-dc790bd2cd6e	\N
1c47c864-6b6f-4fa1-9aad-23ac5b64b2fa	PERSON_ID	openid-connect	oidc-usermodel-attribute-mapper	13cb01d4-5629-41b8-a27c-ba6519581c0e	\N
044cc973-85c6-4602-af92-df9de29eac12	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	3ddef2a9-f6a2-475f-af73-33d10d6508d5	\N
f1d255cf-1d41-40f1-a737-4aa220e0c64f	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	3ddef2a9-f6a2-475f-af73-33d10d6508d5	\N
fd9ba4b1-be91-4fba-9595-132319682254	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	3ddef2a9-f6a2-475f-af73-33d10d6508d5	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
64501e79-c703-46fc-b6f2-f29ebd5c44c6	true	userinfo.token.claim
64501e79-c703-46fc-b6f2-f29ebd5c44c6	locale	user.attribute
64501e79-c703-46fc-b6f2-f29ebd5c44c6	true	id.token.claim
64501e79-c703-46fc-b6f2-f29ebd5c44c6	true	access.token.claim
64501e79-c703-46fc-b6f2-f29ebd5c44c6	locale	claim.name
64501e79-c703-46fc-b6f2-f29ebd5c44c6	String	jsonType.label
c98e48f5-716c-4711-9b40-3cf881295698	false	single
c98e48f5-716c-4711-9b40-3cf881295698	Basic	attribute.nameformat
c98e48f5-716c-4711-9b40-3cf881295698	Role	attribute.name
152801aa-61e5-4f4a-ae86-4d9e8260ddec	true	userinfo.token.claim
152801aa-61e5-4f4a-ae86-4d9e8260ddec	true	id.token.claim
152801aa-61e5-4f4a-ae86-4d9e8260ddec	true	access.token.claim
0815f9ac-2722-460e-9d04-334ef92937ea	true	userinfo.token.claim
0815f9ac-2722-460e-9d04-334ef92937ea	lastName	user.attribute
0815f9ac-2722-460e-9d04-334ef92937ea	true	id.token.claim
0815f9ac-2722-460e-9d04-334ef92937ea	true	access.token.claim
0815f9ac-2722-460e-9d04-334ef92937ea	family_name	claim.name
0815f9ac-2722-460e-9d04-334ef92937ea	String	jsonType.label
6074127e-ac77-4ba4-9382-065227b9a69b	true	userinfo.token.claim
6074127e-ac77-4ba4-9382-065227b9a69b	firstName	user.attribute
6074127e-ac77-4ba4-9382-065227b9a69b	true	id.token.claim
6074127e-ac77-4ba4-9382-065227b9a69b	true	access.token.claim
6074127e-ac77-4ba4-9382-065227b9a69b	given_name	claim.name
6074127e-ac77-4ba4-9382-065227b9a69b	String	jsonType.label
56c9d7ae-4d17-41a6-86a0-53f5708dde12	true	userinfo.token.claim
56c9d7ae-4d17-41a6-86a0-53f5708dde12	middleName	user.attribute
56c9d7ae-4d17-41a6-86a0-53f5708dde12	true	id.token.claim
56c9d7ae-4d17-41a6-86a0-53f5708dde12	true	access.token.claim
56c9d7ae-4d17-41a6-86a0-53f5708dde12	middle_name	claim.name
56c9d7ae-4d17-41a6-86a0-53f5708dde12	String	jsonType.label
c7d4d3c7-abe9-4069-8caf-21d56a3ed9d2	true	userinfo.token.claim
c7d4d3c7-abe9-4069-8caf-21d56a3ed9d2	nickname	user.attribute
c7d4d3c7-abe9-4069-8caf-21d56a3ed9d2	true	id.token.claim
c7d4d3c7-abe9-4069-8caf-21d56a3ed9d2	true	access.token.claim
c7d4d3c7-abe9-4069-8caf-21d56a3ed9d2	nickname	claim.name
c7d4d3c7-abe9-4069-8caf-21d56a3ed9d2	String	jsonType.label
93b49089-b5dd-4d7a-91b2-e49092fa1bc5	true	userinfo.token.claim
93b49089-b5dd-4d7a-91b2-e49092fa1bc5	username	user.attribute
93b49089-b5dd-4d7a-91b2-e49092fa1bc5	true	id.token.claim
93b49089-b5dd-4d7a-91b2-e49092fa1bc5	true	access.token.claim
93b49089-b5dd-4d7a-91b2-e49092fa1bc5	preferred_username	claim.name
93b49089-b5dd-4d7a-91b2-e49092fa1bc5	String	jsonType.label
0bd1d990-a338-4858-9bc7-7daac719a0b3	true	userinfo.token.claim
0bd1d990-a338-4858-9bc7-7daac719a0b3	profile	user.attribute
0bd1d990-a338-4858-9bc7-7daac719a0b3	true	id.token.claim
0bd1d990-a338-4858-9bc7-7daac719a0b3	true	access.token.claim
0bd1d990-a338-4858-9bc7-7daac719a0b3	profile	claim.name
0bd1d990-a338-4858-9bc7-7daac719a0b3	String	jsonType.label
7569db26-91cf-405f-aa5a-9bf2006eee95	true	userinfo.token.claim
7569db26-91cf-405f-aa5a-9bf2006eee95	picture	user.attribute
7569db26-91cf-405f-aa5a-9bf2006eee95	true	id.token.claim
7569db26-91cf-405f-aa5a-9bf2006eee95	true	access.token.claim
7569db26-91cf-405f-aa5a-9bf2006eee95	picture	claim.name
7569db26-91cf-405f-aa5a-9bf2006eee95	String	jsonType.label
7f2ec6d7-daf1-414d-97ac-234fefc8ed63	true	userinfo.token.claim
7f2ec6d7-daf1-414d-97ac-234fefc8ed63	website	user.attribute
7f2ec6d7-daf1-414d-97ac-234fefc8ed63	true	id.token.claim
7f2ec6d7-daf1-414d-97ac-234fefc8ed63	true	access.token.claim
7f2ec6d7-daf1-414d-97ac-234fefc8ed63	website	claim.name
7f2ec6d7-daf1-414d-97ac-234fefc8ed63	String	jsonType.label
b9490d21-3d4f-43f4-8823-fb3b406416c6	true	userinfo.token.claim
b9490d21-3d4f-43f4-8823-fb3b406416c6	gender	user.attribute
b9490d21-3d4f-43f4-8823-fb3b406416c6	true	id.token.claim
b9490d21-3d4f-43f4-8823-fb3b406416c6	true	access.token.claim
b9490d21-3d4f-43f4-8823-fb3b406416c6	gender	claim.name
b9490d21-3d4f-43f4-8823-fb3b406416c6	String	jsonType.label
ffdbe25b-9edb-4e7f-aa1c-1db717534e8d	true	userinfo.token.claim
ffdbe25b-9edb-4e7f-aa1c-1db717534e8d	birthdate	user.attribute
ffdbe25b-9edb-4e7f-aa1c-1db717534e8d	true	id.token.claim
ffdbe25b-9edb-4e7f-aa1c-1db717534e8d	true	access.token.claim
ffdbe25b-9edb-4e7f-aa1c-1db717534e8d	birthdate	claim.name
ffdbe25b-9edb-4e7f-aa1c-1db717534e8d	String	jsonType.label
8dd176f2-3af4-434a-80cd-19064744ce81	true	userinfo.token.claim
8dd176f2-3af4-434a-80cd-19064744ce81	zoneinfo	user.attribute
8dd176f2-3af4-434a-80cd-19064744ce81	true	id.token.claim
8dd176f2-3af4-434a-80cd-19064744ce81	true	access.token.claim
8dd176f2-3af4-434a-80cd-19064744ce81	zoneinfo	claim.name
8dd176f2-3af4-434a-80cd-19064744ce81	String	jsonType.label
ef0181a7-ba17-43a4-82ca-7abc8bdf4548	true	userinfo.token.claim
ef0181a7-ba17-43a4-82ca-7abc8bdf4548	locale	user.attribute
ef0181a7-ba17-43a4-82ca-7abc8bdf4548	true	id.token.claim
ef0181a7-ba17-43a4-82ca-7abc8bdf4548	true	access.token.claim
ef0181a7-ba17-43a4-82ca-7abc8bdf4548	locale	claim.name
ef0181a7-ba17-43a4-82ca-7abc8bdf4548	String	jsonType.label
aad3d7fb-9383-4d8a-a5cc-0d00b04943eb	true	userinfo.token.claim
aad3d7fb-9383-4d8a-a5cc-0d00b04943eb	updatedAt	user.attribute
aad3d7fb-9383-4d8a-a5cc-0d00b04943eb	true	id.token.claim
aad3d7fb-9383-4d8a-a5cc-0d00b04943eb	true	access.token.claim
aad3d7fb-9383-4d8a-a5cc-0d00b04943eb	updated_at	claim.name
aad3d7fb-9383-4d8a-a5cc-0d00b04943eb	String	jsonType.label
1479d6bd-db18-475e-ac52-6d6f14ae425e	true	userinfo.token.claim
1479d6bd-db18-475e-ac52-6d6f14ae425e	email	user.attribute
1479d6bd-db18-475e-ac52-6d6f14ae425e	true	id.token.claim
1479d6bd-db18-475e-ac52-6d6f14ae425e	true	access.token.claim
1479d6bd-db18-475e-ac52-6d6f14ae425e	email	claim.name
1479d6bd-db18-475e-ac52-6d6f14ae425e	String	jsonType.label
4a6bdadf-e0c4-44c5-8493-05c5f07f6bda	true	userinfo.token.claim
4a6bdadf-e0c4-44c5-8493-05c5f07f6bda	emailVerified	user.attribute
4a6bdadf-e0c4-44c5-8493-05c5f07f6bda	true	id.token.claim
4a6bdadf-e0c4-44c5-8493-05c5f07f6bda	true	access.token.claim
4a6bdadf-e0c4-44c5-8493-05c5f07f6bda	email_verified	claim.name
4a6bdadf-e0c4-44c5-8493-05c5f07f6bda	boolean	jsonType.label
7d0ac5a9-4c4d-4d09-8640-eb99abafd18f	formatted	user.attribute.formatted
7d0ac5a9-4c4d-4d09-8640-eb99abafd18f	country	user.attribute.country
7d0ac5a9-4c4d-4d09-8640-eb99abafd18f	postal_code	user.attribute.postal_code
7d0ac5a9-4c4d-4d09-8640-eb99abafd18f	true	userinfo.token.claim
7d0ac5a9-4c4d-4d09-8640-eb99abafd18f	street	user.attribute.street
7d0ac5a9-4c4d-4d09-8640-eb99abafd18f	true	id.token.claim
7d0ac5a9-4c4d-4d09-8640-eb99abafd18f	region	user.attribute.region
7d0ac5a9-4c4d-4d09-8640-eb99abafd18f	true	access.token.claim
7d0ac5a9-4c4d-4d09-8640-eb99abafd18f	locality	user.attribute.locality
37f5a9fa-a948-4145-b15d-3c8279aa6a8d	true	userinfo.token.claim
37f5a9fa-a948-4145-b15d-3c8279aa6a8d	phoneNumber	user.attribute
37f5a9fa-a948-4145-b15d-3c8279aa6a8d	true	id.token.claim
37f5a9fa-a948-4145-b15d-3c8279aa6a8d	true	access.token.claim
37f5a9fa-a948-4145-b15d-3c8279aa6a8d	phone_number	claim.name
37f5a9fa-a948-4145-b15d-3c8279aa6a8d	String	jsonType.label
6e301a78-39db-488b-9462-992c833153ed	true	userinfo.token.claim
6e301a78-39db-488b-9462-992c833153ed	phoneNumberVerified	user.attribute
6e301a78-39db-488b-9462-992c833153ed	true	id.token.claim
6e301a78-39db-488b-9462-992c833153ed	true	access.token.claim
6e301a78-39db-488b-9462-992c833153ed	phone_number_verified	claim.name
6e301a78-39db-488b-9462-992c833153ed	boolean	jsonType.label
d56883b1-022d-4d2d-bd51-917b3b12a1df	true	multivalued
d56883b1-022d-4d2d-bd51-917b3b12a1df	foo	user.attribute
d56883b1-022d-4d2d-bd51-917b3b12a1df	true	access.token.claim
d56883b1-022d-4d2d-bd51-917b3b12a1df	realm_access.roles	claim.name
d56883b1-022d-4d2d-bd51-917b3b12a1df	String	jsonType.label
20379d9f-9a5b-42a3-8145-171f81c2d058	true	multivalued
20379d9f-9a5b-42a3-8145-171f81c2d058	foo	user.attribute
20379d9f-9a5b-42a3-8145-171f81c2d058	true	access.token.claim
20379d9f-9a5b-42a3-8145-171f81c2d058	resource_access.${client_id}.roles	claim.name
20379d9f-9a5b-42a3-8145-171f81c2d058	String	jsonType.label
6359935c-3ee3-44c8-a3d0-893e8746e512	true	userinfo.token.claim
6359935c-3ee3-44c8-a3d0-893e8746e512	username	user.attribute
6359935c-3ee3-44c8-a3d0-893e8746e512	true	id.token.claim
6359935c-3ee3-44c8-a3d0-893e8746e512	true	access.token.claim
6359935c-3ee3-44c8-a3d0-893e8746e512	upn	claim.name
6359935c-3ee3-44c8-a3d0-893e8746e512	String	jsonType.label
d30b401f-8640-4855-816d-4dc3f95b2399	true	multivalued
d30b401f-8640-4855-816d-4dc3f95b2399	foo	user.attribute
d30b401f-8640-4855-816d-4dc3f95b2399	true	id.token.claim
d30b401f-8640-4855-816d-4dc3f95b2399	true	access.token.claim
d30b401f-8640-4855-816d-4dc3f95b2399	groups	claim.name
d30b401f-8640-4855-816d-4dc3f95b2399	String	jsonType.label
131cba59-41eb-4b7b-9eb1-54b8def1d4da	false	single
131cba59-41eb-4b7b-9eb1-54b8def1d4da	Basic	attribute.nameformat
131cba59-41eb-4b7b-9eb1-54b8def1d4da	Role	attribute.name
e2bbda4f-2d60-49e2-a95c-576b357a51a1	true	userinfo.token.claim
e2bbda4f-2d60-49e2-a95c-576b357a51a1	true	id.token.claim
e2bbda4f-2d60-49e2-a95c-576b357a51a1	true	access.token.claim
da1fb1c4-a9ee-4ac3-8342-5ef5645b51ab	true	userinfo.token.claim
da1fb1c4-a9ee-4ac3-8342-5ef5645b51ab	lastName	user.attribute
da1fb1c4-a9ee-4ac3-8342-5ef5645b51ab	true	id.token.claim
da1fb1c4-a9ee-4ac3-8342-5ef5645b51ab	true	access.token.claim
da1fb1c4-a9ee-4ac3-8342-5ef5645b51ab	family_name	claim.name
da1fb1c4-a9ee-4ac3-8342-5ef5645b51ab	String	jsonType.label
71d7e065-d421-4066-9f75-133acb8ee141	true	userinfo.token.claim
71d7e065-d421-4066-9f75-133acb8ee141	firstName	user.attribute
71d7e065-d421-4066-9f75-133acb8ee141	true	id.token.claim
71d7e065-d421-4066-9f75-133acb8ee141	true	access.token.claim
71d7e065-d421-4066-9f75-133acb8ee141	given_name	claim.name
71d7e065-d421-4066-9f75-133acb8ee141	String	jsonType.label
982c2114-b1f0-435b-97c0-0737bfcd3b96	true	userinfo.token.claim
982c2114-b1f0-435b-97c0-0737bfcd3b96	middleName	user.attribute
982c2114-b1f0-435b-97c0-0737bfcd3b96	true	id.token.claim
982c2114-b1f0-435b-97c0-0737bfcd3b96	true	access.token.claim
982c2114-b1f0-435b-97c0-0737bfcd3b96	middle_name	claim.name
982c2114-b1f0-435b-97c0-0737bfcd3b96	String	jsonType.label
df21aad5-2cd7-420e-9758-71ae199445f3	true	userinfo.token.claim
df21aad5-2cd7-420e-9758-71ae199445f3	nickname	user.attribute
df21aad5-2cd7-420e-9758-71ae199445f3	true	id.token.claim
df21aad5-2cd7-420e-9758-71ae199445f3	true	access.token.claim
df21aad5-2cd7-420e-9758-71ae199445f3	nickname	claim.name
df21aad5-2cd7-420e-9758-71ae199445f3	String	jsonType.label
11414972-f6d2-45cf-815d-7fd721c305d4	true	userinfo.token.claim
11414972-f6d2-45cf-815d-7fd721c305d4	username	user.attribute
11414972-f6d2-45cf-815d-7fd721c305d4	true	id.token.claim
11414972-f6d2-45cf-815d-7fd721c305d4	true	access.token.claim
11414972-f6d2-45cf-815d-7fd721c305d4	preferred_username	claim.name
11414972-f6d2-45cf-815d-7fd721c305d4	String	jsonType.label
3c98a78b-024a-478d-9f49-aca518a68c6d	true	userinfo.token.claim
3c98a78b-024a-478d-9f49-aca518a68c6d	profile	user.attribute
3c98a78b-024a-478d-9f49-aca518a68c6d	true	id.token.claim
3c98a78b-024a-478d-9f49-aca518a68c6d	true	access.token.claim
3c98a78b-024a-478d-9f49-aca518a68c6d	profile	claim.name
3c98a78b-024a-478d-9f49-aca518a68c6d	String	jsonType.label
3f43702c-ab36-49d1-b062-779c030854d5	true	userinfo.token.claim
3f43702c-ab36-49d1-b062-779c030854d5	picture	user.attribute
3f43702c-ab36-49d1-b062-779c030854d5	true	id.token.claim
3f43702c-ab36-49d1-b062-779c030854d5	true	access.token.claim
3f43702c-ab36-49d1-b062-779c030854d5	picture	claim.name
3f43702c-ab36-49d1-b062-779c030854d5	String	jsonType.label
bbd1ab2a-fb05-47e8-b418-102f4e160d9d	true	userinfo.token.claim
bbd1ab2a-fb05-47e8-b418-102f4e160d9d	website	user.attribute
bbd1ab2a-fb05-47e8-b418-102f4e160d9d	true	id.token.claim
bbd1ab2a-fb05-47e8-b418-102f4e160d9d	true	access.token.claim
bbd1ab2a-fb05-47e8-b418-102f4e160d9d	website	claim.name
bbd1ab2a-fb05-47e8-b418-102f4e160d9d	String	jsonType.label
613fbc7d-f3f9-4403-a2f1-f55857e8b568	true	userinfo.token.claim
613fbc7d-f3f9-4403-a2f1-f55857e8b568	gender	user.attribute
613fbc7d-f3f9-4403-a2f1-f55857e8b568	true	id.token.claim
613fbc7d-f3f9-4403-a2f1-f55857e8b568	true	access.token.claim
613fbc7d-f3f9-4403-a2f1-f55857e8b568	gender	claim.name
613fbc7d-f3f9-4403-a2f1-f55857e8b568	String	jsonType.label
c4918db1-03d0-427f-9982-955a57fa5957	true	userinfo.token.claim
c4918db1-03d0-427f-9982-955a57fa5957	birthdate	user.attribute
c4918db1-03d0-427f-9982-955a57fa5957	true	id.token.claim
c4918db1-03d0-427f-9982-955a57fa5957	true	access.token.claim
c4918db1-03d0-427f-9982-955a57fa5957	birthdate	claim.name
c4918db1-03d0-427f-9982-955a57fa5957	String	jsonType.label
604e75ab-0a9a-47f8-b2cd-9e1100117710	true	userinfo.token.claim
604e75ab-0a9a-47f8-b2cd-9e1100117710	zoneinfo	user.attribute
604e75ab-0a9a-47f8-b2cd-9e1100117710	true	id.token.claim
604e75ab-0a9a-47f8-b2cd-9e1100117710	true	access.token.claim
604e75ab-0a9a-47f8-b2cd-9e1100117710	zoneinfo	claim.name
604e75ab-0a9a-47f8-b2cd-9e1100117710	String	jsonType.label
adc06ad8-0ef3-4c4a-a6c8-8b72af7b0dc8	true	userinfo.token.claim
adc06ad8-0ef3-4c4a-a6c8-8b72af7b0dc8	locale	user.attribute
adc06ad8-0ef3-4c4a-a6c8-8b72af7b0dc8	true	id.token.claim
adc06ad8-0ef3-4c4a-a6c8-8b72af7b0dc8	true	access.token.claim
adc06ad8-0ef3-4c4a-a6c8-8b72af7b0dc8	locale	claim.name
adc06ad8-0ef3-4c4a-a6c8-8b72af7b0dc8	String	jsonType.label
71314d62-c7fa-4893-ad6f-794c3a399dc1	true	userinfo.token.claim
71314d62-c7fa-4893-ad6f-794c3a399dc1	updatedAt	user.attribute
71314d62-c7fa-4893-ad6f-794c3a399dc1	true	id.token.claim
71314d62-c7fa-4893-ad6f-794c3a399dc1	true	access.token.claim
71314d62-c7fa-4893-ad6f-794c3a399dc1	updated_at	claim.name
71314d62-c7fa-4893-ad6f-794c3a399dc1	String	jsonType.label
995880c9-68d4-47b5-83b0-47bc1921dc79	true	userinfo.token.claim
995880c9-68d4-47b5-83b0-47bc1921dc79	email	user.attribute
995880c9-68d4-47b5-83b0-47bc1921dc79	true	id.token.claim
995880c9-68d4-47b5-83b0-47bc1921dc79	true	access.token.claim
995880c9-68d4-47b5-83b0-47bc1921dc79	email	claim.name
995880c9-68d4-47b5-83b0-47bc1921dc79	String	jsonType.label
98626b8b-8fe0-408c-9015-d3fa38544f24	true	userinfo.token.claim
98626b8b-8fe0-408c-9015-d3fa38544f24	emailVerified	user.attribute
98626b8b-8fe0-408c-9015-d3fa38544f24	true	id.token.claim
98626b8b-8fe0-408c-9015-d3fa38544f24	true	access.token.claim
98626b8b-8fe0-408c-9015-d3fa38544f24	email_verified	claim.name
98626b8b-8fe0-408c-9015-d3fa38544f24	boolean	jsonType.label
3fd3ba54-72d3-483f-a508-657e179d0174	formatted	user.attribute.formatted
3fd3ba54-72d3-483f-a508-657e179d0174	country	user.attribute.country
3fd3ba54-72d3-483f-a508-657e179d0174	postal_code	user.attribute.postal_code
3fd3ba54-72d3-483f-a508-657e179d0174	true	userinfo.token.claim
3fd3ba54-72d3-483f-a508-657e179d0174	street	user.attribute.street
3fd3ba54-72d3-483f-a508-657e179d0174	true	id.token.claim
3fd3ba54-72d3-483f-a508-657e179d0174	region	user.attribute.region
3fd3ba54-72d3-483f-a508-657e179d0174	true	access.token.claim
3fd3ba54-72d3-483f-a508-657e179d0174	locality	user.attribute.locality
08722b7d-e639-4e83-aad0-d8ca2ecfc9ae	true	userinfo.token.claim
08722b7d-e639-4e83-aad0-d8ca2ecfc9ae	phoneNumber	user.attribute
08722b7d-e639-4e83-aad0-d8ca2ecfc9ae	true	id.token.claim
08722b7d-e639-4e83-aad0-d8ca2ecfc9ae	true	access.token.claim
08722b7d-e639-4e83-aad0-d8ca2ecfc9ae	phone_number	claim.name
08722b7d-e639-4e83-aad0-d8ca2ecfc9ae	String	jsonType.label
36fc92f2-b408-4a66-8194-4341f7727e90	true	userinfo.token.claim
36fc92f2-b408-4a66-8194-4341f7727e90	phoneNumberVerified	user.attribute
36fc92f2-b408-4a66-8194-4341f7727e90	true	id.token.claim
36fc92f2-b408-4a66-8194-4341f7727e90	true	access.token.claim
36fc92f2-b408-4a66-8194-4341f7727e90	phone_number_verified	claim.name
36fc92f2-b408-4a66-8194-4341f7727e90	boolean	jsonType.label
073f6f50-5b50-4939-94b4-b1f315ee2f69	true	multivalued
073f6f50-5b50-4939-94b4-b1f315ee2f69	foo	user.attribute
073f6f50-5b50-4939-94b4-b1f315ee2f69	true	access.token.claim
073f6f50-5b50-4939-94b4-b1f315ee2f69	realm_access.roles	claim.name
073f6f50-5b50-4939-94b4-b1f315ee2f69	String	jsonType.label
0c0b9b6f-7e15-4f69-9f2c-498a714a2880	true	multivalued
0c0b9b6f-7e15-4f69-9f2c-498a714a2880	foo	user.attribute
0c0b9b6f-7e15-4f69-9f2c-498a714a2880	true	access.token.claim
0c0b9b6f-7e15-4f69-9f2c-498a714a2880	resource_access.${client_id}.roles	claim.name
0c0b9b6f-7e15-4f69-9f2c-498a714a2880	String	jsonType.label
e45dc056-c4d8-4df5-b8fc-7979b147f271	true	userinfo.token.claim
e45dc056-c4d8-4df5-b8fc-7979b147f271	username	user.attribute
e45dc056-c4d8-4df5-b8fc-7979b147f271	true	id.token.claim
e45dc056-c4d8-4df5-b8fc-7979b147f271	true	access.token.claim
e45dc056-c4d8-4df5-b8fc-7979b147f271	upn	claim.name
e45dc056-c4d8-4df5-b8fc-7979b147f271	String	jsonType.label
fc4c7a00-bdce-4026-966b-e8e38d38cb28	true	multivalued
fc4c7a00-bdce-4026-966b-e8e38d38cb28	foo	user.attribute
fc4c7a00-bdce-4026-966b-e8e38d38cb28	true	id.token.claim
fc4c7a00-bdce-4026-966b-e8e38d38cb28	true	access.token.claim
fc4c7a00-bdce-4026-966b-e8e38d38cb28	groups	claim.name
fc4c7a00-bdce-4026-966b-e8e38d38cb28	String	jsonType.label
f6b7b9ac-bb63-46c2-96d2-805b1f36c38a	true	userinfo.token.claim
f6b7b9ac-bb63-46c2-96d2-805b1f36c38a	locale	user.attribute
f6b7b9ac-bb63-46c2-96d2-805b1f36c38a	true	id.token.claim
f6b7b9ac-bb63-46c2-96d2-805b1f36c38a	true	access.token.claim
f6b7b9ac-bb63-46c2-96d2-805b1f36c38a	locale	claim.name
f6b7b9ac-bb63-46c2-96d2-805b1f36c38a	String	jsonType.label
4e7c74aa-14e5-434d-9b20-633ab35910c2	clientAddress	user.session.note
4e7c74aa-14e5-434d-9b20-633ab35910c2	true	id.token.claim
4e7c74aa-14e5-434d-9b20-633ab35910c2	true	access.token.claim
4e7c74aa-14e5-434d-9b20-633ab35910c2	clientAddress	claim.name
4e7c74aa-14e5-434d-9b20-633ab35910c2	String	jsonType.label
4e7c74aa-14e5-434d-9b20-633ab35910c2	true	userinfo.token.claim
74c225e9-6716-46f2-af65-aab928f2e7af	clientId	user.session.note
74c225e9-6716-46f2-af65-aab928f2e7af	true	id.token.claim
74c225e9-6716-46f2-af65-aab928f2e7af	true	access.token.claim
74c225e9-6716-46f2-af65-aab928f2e7af	clientId	claim.name
74c225e9-6716-46f2-af65-aab928f2e7af	String	jsonType.label
3362bb26-34e5-42de-861c-40011a820ce6	clientHost	user.session.note
3362bb26-34e5-42de-861c-40011a820ce6	true	id.token.claim
3362bb26-34e5-42de-861c-40011a820ce6	true	access.token.claim
3362bb26-34e5-42de-861c-40011a820ce6	clientHost	claim.name
3362bb26-34e5-42de-861c-40011a820ce6	String	jsonType.label
74c225e9-6716-46f2-af65-aab928f2e7af	true	userinfo.token.claim
3362bb26-34e5-42de-861c-40011a820ce6	true	userinfo.token.claim
1c47c864-6b6f-4fa1-9aad-23ac5b64b2fa	true	userinfo.token.claim
1c47c864-6b6f-4fa1-9aad-23ac5b64b2fa	PERSON_ID	user.attribute
1c47c864-6b6f-4fa1-9aad-23ac5b64b2fa	true	id.token.claim
1c47c864-6b6f-4fa1-9aad-23ac5b64b2fa	true	access.token.claim
1c47c864-6b6f-4fa1-9aad-23ac5b64b2fa	personId	claim.name
1c47c864-6b6f-4fa1-9aad-23ac5b64b2fa	String	jsonType.label
044cc973-85c6-4602-af92-df9de29eac12	clientId	user.session.note
044cc973-85c6-4602-af92-df9de29eac12	true	id.token.claim
044cc973-85c6-4602-af92-df9de29eac12	true	access.token.claim
044cc973-85c6-4602-af92-df9de29eac12	clientId	claim.name
044cc973-85c6-4602-af92-df9de29eac12	String	jsonType.label
f1d255cf-1d41-40f1-a737-4aa220e0c64f	clientHost	user.session.note
f1d255cf-1d41-40f1-a737-4aa220e0c64f	true	id.token.claim
f1d255cf-1d41-40f1-a737-4aa220e0c64f	true	access.token.claim
f1d255cf-1d41-40f1-a737-4aa220e0c64f	clientHost	claim.name
f1d255cf-1d41-40f1-a737-4aa220e0c64f	String	jsonType.label
fd9ba4b1-be91-4fba-9595-132319682254	clientAddress	user.session.note
fd9ba4b1-be91-4fba-9595-132319682254	true	id.token.claim
fd9ba4b1-be91-4fba-9595-132319682254	true	access.token.claim
fd9ba4b1-be91-4fba-9595-132319682254	clientAddress	claim.name
fd9ba4b1-be91-4fba-9595-132319682254	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
master	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	57aed360-afb0-44a1-b480-f2b6f74bdab4	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	e6d64ede-1a4b-4802-bd65-2cb3b5d068b2	a4d154e3-b19b-4635-b8ba-a3b04a74b2d1	07a0ce42-da16-45fb-ae96-9964fca76605	a714b25d-bf21-4195-89b2-2e0a24de196c	40a1b354-9df0-4907-b6e2-90d10774663e	2592000	f	900	t	f	ef33e11d-e7fe-47f7-a760-ab561aea2c4e	0	f	0	0	f61fe5ec-00ee-414b-8be3-6acde04f14cf
pkb-fhir	60	300	300	\N	\N	\N	t	f	0	\N	pkb-fhir	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	e7b4b8cc-790e-48fd-858c-bc5fffabeb41	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	8adafb64-f5a8-424e-b79e-0f6646c6d6d0	cf258020-dd88-4266-9e1c-fabaa0596805	16636059-937d-4ab2-90f8-c4ff5f1eec9f	d6fa4daf-3120-4007-a377-36d4841d3eff	60d9901a-81dd-4701-87b7-2338e93e2dfe	2592000	f	900	t	f	6cc7a277-b010-4c34-bfd0-1c98408a4ac3	0	f	0	0	70db86dd-42ea-4dbe-a7f9-1752b34f5635
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	master	
_browser_header.xContentTypeOptions	master	nosniff
_browser_header.xRobotsTag	master	none
_browser_header.xFrameOptions	master	SAMEORIGIN
_browser_header.contentSecurityPolicy	master	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	master	1; mode=block
_browser_header.strictTransportSecurity	master	max-age=31536000; includeSubDomains
bruteForceProtected	master	false
permanentLockout	master	false
maxFailureWaitSeconds	master	900
minimumQuickLoginWaitSeconds	master	60
waitIncrementSeconds	master	60
quickLoginCheckMilliSeconds	master	1000
maxDeltaTimeSeconds	master	43200
failureFactor	master	30
client-policies.profiles	master	{"profiles":[{"name":"builtin-default-profile","description":"The built-in default profile for enforcing basic security level to clients.","builtin":true,"executors":[{"secure-session-enforce-executor":{}}]}]}
client-policies.policies	master	{"policies":[{"name":"builtin-default-policy","description":"The built-in default policy applied to all clients.","builtin":true,"enable":false,"conditions":[{"anyclient-condition":{}}],"profiles":["builtin-default-profile"]}]}
displayName	master	Keycloak
displayNameHtml	master	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	master	RS256
offlineSessionMaxLifespanEnabled	master	false
offlineSessionMaxLifespan	master	5184000
_browser_header.contentSecurityPolicyReportOnly	pkb-fhir	
_browser_header.xContentTypeOptions	pkb-fhir	nosniff
_browser_header.xRobotsTag	pkb-fhir	none
_browser_header.xFrameOptions	pkb-fhir	SAMEORIGIN
_browser_header.contentSecurityPolicy	pkb-fhir	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	pkb-fhir	1; mode=block
_browser_header.strictTransportSecurity	pkb-fhir	max-age=31536000; includeSubDomains
bruteForceProtected	pkb-fhir	false
permanentLockout	pkb-fhir	false
maxFailureWaitSeconds	pkb-fhir	900
minimumQuickLoginWaitSeconds	pkb-fhir	60
waitIncrementSeconds	pkb-fhir	60
quickLoginCheckMilliSeconds	pkb-fhir	1000
maxDeltaTimeSeconds	pkb-fhir	43200
failureFactor	pkb-fhir	30
defaultSignatureAlgorithm	pkb-fhir	RS256
offlineSessionMaxLifespanEnabled	pkb-fhir	false
offlineSessionMaxLifespan	pkb-fhir	5184000
actionTokenGeneratedByAdminLifespan	pkb-fhir	43200
actionTokenGeneratedByUserLifespan	pkb-fhir	300
oauth2DeviceCodeLifespan	pkb-fhir	600
oauth2DevicePollingInterval	pkb-fhir	5
webAuthnPolicyRpEntityName	pkb-fhir	keycloak
webAuthnPolicySignatureAlgorithms	pkb-fhir	ES256
webAuthnPolicyRpId	pkb-fhir	
webAuthnPolicyAttestationConveyancePreference	pkb-fhir	not specified
webAuthnPolicyAuthenticatorAttachment	pkb-fhir	not specified
webAuthnPolicyRequireResidentKey	pkb-fhir	not specified
webAuthnPolicyUserVerificationRequirement	pkb-fhir	not specified
webAuthnPolicyCreateTimeout	pkb-fhir	0
webAuthnPolicyAvoidSameAuthenticatorRegister	pkb-fhir	false
webAuthnPolicyRpEntityNamePasswordless	pkb-fhir	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	pkb-fhir	ES256
webAuthnPolicyRpIdPasswordless	pkb-fhir	
webAuthnPolicyAttestationConveyancePreferencePasswordless	pkb-fhir	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	pkb-fhir	not specified
webAuthnPolicyRequireResidentKeyPasswordless	pkb-fhir	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	pkb-fhir	not specified
webAuthnPolicyCreateTimeoutPasswordless	pkb-fhir	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	pkb-fhir	false
cibaBackchannelTokenDeliveryMode	pkb-fhir	poll
cibaExpiresIn	pkb-fhir	120
cibaInterval	pkb-fhir	5
cibaAuthRequestedUserHint	pkb-fhir	login_hint
client-policies.profiles	pkb-fhir	{"profiles":[{"name":"builtin-default-profile","description":"The built-in default profile for enforcing basic security level to clients.","builtin":true,"executors":[{"secure-session-enforce-executor":{}}]}]}
client-policies.policies	pkb-fhir	{"policies":[{"name":"builtin-default-policy","description":"The built-in default policy applied to all clients.","builtin":true,"enable":false,"conditions":[{"anyclient-condition":{}}],"profiles":["builtin-default-profile"]}]}
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
master	jboss-logging
pkb-fhir	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	master
password	password	t	t	pkb-fhir
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.redirect_uris (client_id, value) FROM stdin;
b4a9b818-2099-4d12-bfae-867f5ce288b3	/realms/master/account/*
12ddecff-fe86-4fec-9e67-fd3db715f772	/realms/master/account/*
0d2f3cc8-e788-4558-be62-c06c1581a14d	/admin/master/console/*
9829268b-9da1-4fd0-a953-9078144d2774	/realms/pkb-fhir/account/*
57b71758-9d62-4c0f-9b02-7ae1201e81a3	/realms/pkb-fhir/account/*
2496af99-dc8b-4bad-afea-9c1be3d8c437	/admin/pkb-fhir/console/*
13cb01d4-5629-41b8-a27c-ba6519581c0e	http://fakepkb.local/*
f18864b2-c169-4a00-acd7-dc790bd2cd6e	http://localhost/fhir/*
3ddef2a9-f6a2-475f-af73-33d10d6508d5	/
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
3d5a0b8f-1193-4c28-bf2f-989c79630918	VERIFY_EMAIL	Verify Email	master	t	f	VERIFY_EMAIL	50
1214fa47-7103-4687-80b2-9f11759d303f	UPDATE_PROFILE	Update Profile	master	t	f	UPDATE_PROFILE	40
5bd243ee-a444-4ca1-8555-cfc90de449af	CONFIGURE_TOTP	Configure OTP	master	t	f	CONFIGURE_TOTP	10
3cec00fc-65aa-49d3-8440-a1ff784f3ff2	UPDATE_PASSWORD	Update Password	master	t	f	UPDATE_PASSWORD	30
f40c3f5b-4189-4e6f-8ea3-7cd68b1b184b	terms_and_conditions	Terms and Conditions	master	f	f	terms_and_conditions	20
d4ab5280-6b57-463a-b14a-4ceb0a8d866a	update_user_locale	Update User Locale	master	t	f	update_user_locale	1000
d659b6ca-49b8-4b52-bd42-4d291d532d3f	delete_account	Delete Account	master	f	f	delete_account	60
e3f403fe-7796-451d-a9b3-7f24fa36d563	VERIFY_EMAIL	Verify Email	pkb-fhir	t	f	VERIFY_EMAIL	50
8d87944e-161b-4a91-9e1e-833c6be82c64	UPDATE_PROFILE	Update Profile	pkb-fhir	t	f	UPDATE_PROFILE	40
229182fb-1247-49db-87e7-5c39d59d61b8	CONFIGURE_TOTP	Configure OTP	pkb-fhir	t	f	CONFIGURE_TOTP	10
2595a7d8-b669-426e-ad03-28e7847d9e80	UPDATE_PASSWORD	Update Password	pkb-fhir	t	f	UPDATE_PASSWORD	30
64ce8902-b018-4b87-8137-926d6c3f42c5	terms_and_conditions	Terms and Conditions	pkb-fhir	f	f	terms_and_conditions	20
1d601a85-163d-48d7-b6e9-038035b23c30	update_user_locale	Update User Locale	pkb-fhir	t	f	update_user_locale	1000
7d4ba35f-ec1f-4881-bfc9-f700d594f245	delete_account	Delete Account	pkb-fhir	f	f	delete_account	60
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
12ddecff-fe86-4fec-9e67-fd3db715f772	d6f3d2f8-5843-428d-bb9f-04078ca05b60
57b71758-9d62-4c0f-9b02-7ae1201e81a3	cee77f27-4c66-4321-ac39-e66721c8cc9c
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
PERSON_ID	11502	d1ed8b5d-cfa6-493b-92e1-75f63b61bd4a	4cdfd01d-3cb9-4a59-845c-d0e00ab279cf
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
27259e8e-75ac-4c19-9f28-c306cfa1801c	\N	286e1e7c-8b38-4ea2-bea0-032904b7aad1	f	t	\N	\N	\N	master	admin	1620855364657	\N	0
d1ed8b5d-cfa6-493b-92e1-75f63b61bd4a	\N	181b0870-b0bd-43c6-9d10-07f3786f36d7	f	t	\N	Martin	Ashby	pkb-fhir	martin	1620855477201	\N	0
7bd5267a-ebc7-4a25-8bf1-f392751cf581	\N	61700b1f-3880-445b-9c4d-dfd5645ce831	f	t	\N	\N	\N	pkb-fhir	service-account-pkb-fhir-system	1621353968684	3ddef2a9-f6a2-475f-af73-33d10d6508d5	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
f61fe5ec-00ee-414b-8be3-6acde04f14cf	27259e8e-75ac-4c19-9f28-c306cfa1801c
3e2e8a9e-9261-45a7-9602-aa6957163810	27259e8e-75ac-4c19-9f28-c306cfa1801c
70db86dd-42ea-4dbe-a7f9-1752b34f5635	d1ed8b5d-cfa6-493b-92e1-75f63b61bd4a
70db86dd-42ea-4dbe-a7f9-1752b34f5635	7bd5267a-ebc7-4a25-8bf1-f392751cf581
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.web_origins (client_id, value) FROM stdin;
0d2f3cc8-e788-4558-be62-c06c1581a14d	+
2496af99-dc8b-4bad-afea-9c1be3d8c437	+
13cb01d4-5629-41b8-a27c-ba6519581c0e	http://fakepkb.local
f18864b2-c169-4a00-acd7-dc790bd2cd6e	http://localhost
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: databasechangeloglock pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

