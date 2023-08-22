--
-- PostgreSQL database dump
--

-- Dumped from database version 15.0 (Debian 15.0-1.pgdg110+1)
-- Dumped by pg_dump version 15.0 (Debian 15.0-1.pgdg110+1)

-- Started on 2023-05-10 18:55:34 UTC

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

--
-- TOC entry 4239 (class 1262 OID 16385)
-- Name: keycloak; Type: DATABASE; Schema: -; Owner: admin
--

CREATE DATABASE fhir WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';
CREATE DATABASE keycloak WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE keycloak OWNER TO admin;

\connect keycloak

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
-- TOC entry 214 (class 1259 OID 16386)
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: admin
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


ALTER TABLE public.admin_event_entity OWNER TO admin;

--
-- TOC entry 215 (class 1259 OID 16391)
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO admin;

--
-- TOC entry 216 (class 1259 OID 16394)
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: admin
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


ALTER TABLE public.authentication_execution OWNER TO admin;

--
-- TOC entry 217 (class 1259 OID 16398)
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: admin
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


ALTER TABLE public.authentication_flow OWNER TO admin;

--
-- TOC entry 218 (class 1259 OID 16406)
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO admin;

--
-- TOC entry 219 (class 1259 OID 16409)
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO admin;

--
-- TOC entry 220 (class 1259 OID 16414)
-- Name: broker_link; Type: TABLE; Schema: public; Owner: admin
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


ALTER TABLE public.broker_link OWNER TO admin;

--
-- TOC entry 221 (class 1259 OID 16419)
-- Name: client; Type: TABLE; Schema: public; Owner: admin
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


ALTER TABLE public.client OWNER TO admin;

--
-- TOC entry 222 (class 1259 OID 16437)
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_attributes OWNER TO admin;

--
-- TOC entry 223 (class 1259 OID 16442)
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO admin;

--
-- TOC entry 224 (class 1259 OID 16445)
-- Name: client_default_roles; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_default_roles (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_default_roles OWNER TO admin;

--
-- TOC entry 225 (class 1259 OID 16448)
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO admin;

--
-- TOC entry 226 (class 1259 OID 16451)
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO admin;

--
-- TOC entry 227 (class 1259 OID 16454)
-- Name: client_scope; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO admin;

--
-- TOC entry 228 (class 1259 OID 16459)
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO admin;

--
-- TOC entry 229 (class 1259 OID 16464)
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_scope_client (
    client_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO admin;

--
-- TOC entry 230 (class 1259 OID 16468)
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO admin;

--
-- TOC entry 231 (class 1259 OID 16471)
-- Name: client_session; Type: TABLE; Schema: public; Owner: admin
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


ALTER TABLE public.client_session OWNER TO admin;

--
-- TOC entry 232 (class 1259 OID 16476)
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO admin;

--
-- TOC entry 233 (class 1259 OID 16479)
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO admin;

--
-- TOC entry 234 (class 1259 OID 16484)
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO admin;

--
-- TOC entry 235 (class 1259 OID 16487)
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO admin;

--
-- TOC entry 236 (class 1259 OID 16490)
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO admin;

--
-- TOC entry 237 (class 1259 OID 16495)
-- Name: component; Type: TABLE; Schema: public; Owner: admin
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


ALTER TABLE public.component OWNER TO admin;

--
-- TOC entry 238 (class 1259 OID 16500)
-- Name: component_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE public.component_config OWNER TO admin;

--
-- TOC entry 239 (class 1259 OID 16505)
-- Name: composite_role; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO admin;

--
-- TOC entry 240 (class 1259 OID 16508)
-- Name: credential; Type: TABLE; Schema: public; Owner: admin
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


ALTER TABLE public.credential OWNER TO admin;

--
-- TOC entry 241 (class 1259 OID 16513)
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: admin
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


ALTER TABLE public.databasechangelog OWNER TO admin;

--
-- TOC entry 242 (class 1259 OID 16518)
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO admin;

--
-- TOC entry 243 (class 1259 OID 16521)
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO admin;

--
-- TOC entry 244 (class 1259 OID 16525)
-- Name: event_entity; Type: TABLE; Schema: public; Owner: admin
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


ALTER TABLE public.event_entity OWNER TO admin;

--
-- TOC entry 245 (class 1259 OID 16530)
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO admin;

--
-- TOC entry 246 (class 1259 OID 16535)
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: admin
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


ALTER TABLE public.fed_user_consent OWNER TO admin;

--
-- TOC entry 247 (class 1259 OID 16540)
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO admin;

--
-- TOC entry 248 (class 1259 OID 16543)
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: admin
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


ALTER TABLE public.fed_user_credential OWNER TO admin;

--
-- TOC entry 249 (class 1259 OID 16548)
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO admin;

--
-- TOC entry 250 (class 1259 OID 16551)
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO admin;

--
-- TOC entry 251 (class 1259 OID 16557)
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO admin;

--
-- TOC entry 252 (class 1259 OID 16560)
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO admin;

--
-- TOC entry 253 (class 1259 OID 16565)
-- Name: federated_user; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO admin;

--
-- TOC entry 254 (class 1259 OID 16570)
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO admin;

--
-- TOC entry 255 (class 1259 OID 16576)
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO admin;

--
-- TOC entry 256 (class 1259 OID 16579)
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: admin
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


ALTER TABLE public.identity_provider OWNER TO admin;

--
-- TOC entry 257 (class 1259 OID 16590)
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO admin;

--
-- TOC entry 258 (class 1259 OID 16595)
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO admin;

--
-- TOC entry 259 (class 1259 OID 16600)
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO admin;

--
-- TOC entry 260 (class 1259 OID 16605)
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO admin;

--
-- TOC entry 261 (class 1259 OID 16608)
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: admin
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


ALTER TABLE public.keycloak_role OWNER TO admin;

--
-- TOC entry 262 (class 1259 OID 16614)
-- Name: migration_model; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO admin;

--
-- TOC entry 263 (class 1259 OID 16618)
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: admin
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


ALTER TABLE public.offline_client_session OWNER TO admin;

--
-- TOC entry 264 (class 1259 OID 16625)
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: admin
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


ALTER TABLE public.offline_user_session OWNER TO admin;

--
-- TOC entry 265 (class 1259 OID 16631)
-- Name: policy_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO admin;

--
-- TOC entry 266 (class 1259 OID 16636)
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO admin;

--
-- TOC entry 267 (class 1259 OID 16641)
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO admin;

--
-- TOC entry 268 (class 1259 OID 16646)
-- Name: realm; Type: TABLE; Schema: public; Owner: admin
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
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.realm OWNER TO admin;

--
-- TOC entry 269 (class 1259 OID 16679)
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_attribute OWNER TO admin;

--
-- TOC entry 270 (class 1259 OID 16684)
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO admin;

--
-- TOC entry 271 (class 1259 OID 16687)
-- Name: realm_default_roles; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm_default_roles (
    realm_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_roles OWNER TO admin;

--
-- TOC entry 272 (class 1259 OID 16690)
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO admin;

--
-- TOC entry 273 (class 1259 OID 16693)
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO admin;

--
-- TOC entry 274 (class 1259 OID 16696)
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO admin;

--
-- TOC entry 275 (class 1259 OID 16701)
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO admin;

--
-- TOC entry 276 (class 1259 OID 16708)
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO admin;

--
-- TOC entry 277 (class 1259 OID 16713)
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO admin;

--
-- TOC entry 278 (class 1259 OID 16716)
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO admin;

--
-- TOC entry 279 (class 1259 OID 16719)
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO admin;

--
-- TOC entry 280 (class 1259 OID 16724)
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: admin
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


ALTER TABLE public.required_action_provider OWNER TO admin;

--
-- TOC entry 281 (class 1259 OID 16731)
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO admin;

--
-- TOC entry 282 (class 1259 OID 16737)
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO admin;

--
-- TOC entry 283 (class 1259 OID 16740)
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO admin;

--
-- TOC entry 284 (class 1259 OID 16743)
-- Name: resource_server; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO admin;

--
-- TOC entry 285 (class 1259 OID 16748)
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: admin
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


ALTER TABLE public.resource_server_perm_ticket OWNER TO admin;

--
-- TOC entry 286 (class 1259 OID 16753)
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: admin
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


ALTER TABLE public.resource_server_policy OWNER TO admin;

--
-- TOC entry 287 (class 1259 OID 16758)
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: admin
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


ALTER TABLE public.resource_server_resource OWNER TO admin;

--
-- TOC entry 288 (class 1259 OID 16764)
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO admin;

--
-- TOC entry 289 (class 1259 OID 16769)
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO admin;

--
-- TOC entry 290 (class 1259 OID 16772)
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO admin;

--
-- TOC entry 291 (class 1259 OID 16777)
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO admin;

--
-- TOC entry 292 (class 1259 OID 16780)
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO admin;

--
-- TOC entry 293 (class 1259 OID 16783)
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO admin;

--
-- TOC entry 294 (class 1259 OID 16789)
-- Name: user_consent; Type: TABLE; Schema: public; Owner: admin
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


ALTER TABLE public.user_consent OWNER TO admin;

--
-- TOC entry 295 (class 1259 OID 16794)
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO admin;

--
-- TOC entry 296 (class 1259 OID 16797)
-- Name: user_entity; Type: TABLE; Schema: public; Owner: admin
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


ALTER TABLE public.user_entity OWNER TO admin;

--
-- TOC entry 297 (class 1259 OID 16805)
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO admin;

--
-- TOC entry 298 (class 1259 OID 16810)
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO admin;

--
-- TOC entry 299 (class 1259 OID 16815)
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO admin;

--
-- TOC entry 300 (class 1259 OID 16820)
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: admin
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


ALTER TABLE public.user_federation_provider OWNER TO admin;

--
-- TOC entry 301 (class 1259 OID 16825)
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO admin;

--
-- TOC entry 302 (class 1259 OID 16828)
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO admin;

--
-- TOC entry 303 (class 1259 OID 16832)
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO admin;

--
-- TOC entry 304 (class 1259 OID 16835)
-- Name: user_session; Type: TABLE; Schema: public; Owner: admin
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


ALTER TABLE public.user_session OWNER TO admin;

--
-- TOC entry 305 (class 1259 OID 16841)
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO admin;

--
-- TOC entry 306 (class 1259 OID 16846)
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO admin;

--
-- TOC entry 307 (class 1259 OID 16851)
-- Name: web_origins; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO admin;

--
-- TOC entry 4140 (class 0 OID 16386)
-- Dependencies: 214
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4141 (class 0 OID 16391)
-- Dependencies: 215
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('564f17f2-b764-4205-b51a-11c0505cfa37', '09932e6c-5f26-4322-b346-83e6282bd81a');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('5cf293bc-e1a9-479a-b503-561e0fa99fc6', '5ed10474-21bf-40e9-bbb3-f80eab73baaa');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('9391162c-e6ba-48fd-99bd-31c1ef627695', '5ed10474-21bf-40e9-bbb3-f80eab73baaa');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('19bcdfb7-989c-4daf-a9ca-6b5e8951b97b', '5ed10474-21bf-40e9-bbb3-f80eab73baaa');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('67007f3b-7afc-4e4a-99c3-7953f2b5977a', '5ed10474-21bf-40e9-bbb3-f80eab73baaa');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('fb9c26ce-060c-4dc5-a7b8-45ac7b6bfa4f', '5ed10474-21bf-40e9-bbb3-f80eab73baaa');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('e6115285-34ec-4fa2-a088-3003ab8ba657', '5ed10474-21bf-40e9-bbb3-f80eab73baaa');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('cd7122ba-e2eb-4b30-81d3-ae0831a33d01', '5ed10474-21bf-40e9-bbb3-f80eab73baaa');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('7633a042-a1ba-45c3-8955-10844bf405e1', '5ed10474-21bf-40e9-bbb3-f80eab73baaa');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('f8768963-1c2f-46ec-a8d4-b18d9a0e73a6', '5ed10474-21bf-40e9-bbb3-f80eab73baaa');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('eda6a66d-ad9c-4e4f-a73d-60877b2e1c52', 'f9b6ce0f-635b-4ba0-961b-39f98ba3fb6b');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('eda6a66d-ad9c-4e4f-a73d-60877b2e1c52', 'de9e7111-fc7c-4e3c-9462-40c25d524f94');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('eda6a66d-ad9c-4e4f-a73d-60877b2e1c52', '5ed10474-21bf-40e9-bbb3-f80eab73baaa');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('8df78ad8-7c78-4a63-af78-f405664a1046', 'f9b6ce0f-635b-4ba0-961b-39f98ba3fb6b');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('8df78ad8-7c78-4a63-af78-f405664a1046', 'de9e7111-fc7c-4e3c-9462-40c25d524f94');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('8df78ad8-7c78-4a63-af78-f405664a1046', '29b6112f-abdc-407c-888f-37915d530d29');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('b52ca339-e25b-4959-9b51-404fa891805c', 'f9b6ce0f-635b-4ba0-961b-39f98ba3fb6b');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('b52ca339-e25b-4959-9b51-404fa891805c', 'de9e7111-fc7c-4e3c-9462-40c25d524f94');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('6e9f1189-a7af-440f-9b88-60f34fcb97f8', 'de9e7111-fc7c-4e3c-9462-40c25d524f94');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('6e9f1189-a7af-440f-9b88-60f34fcb97f8', 'f9b6ce0f-635b-4ba0-961b-39f98ba3fb6b');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('6e9f1189-a7af-440f-9b88-60f34fcb97f8', '5ed10474-21bf-40e9-bbb3-f80eab73baaa');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('b52ca339-e25b-4959-9b51-404fa891805c', '5ed10474-21bf-40e9-bbb3-f80eab73baaa');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('1c75c85d-2112-4f8c-a745-06d9a255e49c', 'f9b6ce0f-635b-4ba0-961b-39f98ba3fb6b');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('1c75c85d-2112-4f8c-a745-06d9a255e49c', 'de9e7111-fc7c-4e3c-9462-40c25d524f94');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('1c75c85d-2112-4f8c-a745-06d9a255e49c', '5ed10474-21bf-40e9-bbb3-f80eab73baaa');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('5565ee4f-f4e6-423d-b174-8eb5ae8bff2a', 'f9b6ce0f-635b-4ba0-961b-39f98ba3fb6b');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('5565ee4f-f4e6-423d-b174-8eb5ae8bff2a', 'de9e7111-fc7c-4e3c-9462-40c25d524f94');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('5565ee4f-f4e6-423d-b174-8eb5ae8bff2a', '5ed10474-21bf-40e9-bbb3-f80eab73baaa');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('d5528bfa-aa34-4328-a0c0-80543c201d70', 'f9b6ce0f-635b-4ba0-961b-39f98ba3fb6b');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('d5528bfa-aa34-4328-a0c0-80543c201d70', 'de9e7111-fc7c-4e3c-9462-40c25d524f94');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('d5528bfa-aa34-4328-a0c0-80543c201d70', '5ed10474-21bf-40e9-bbb3-f80eab73baaa');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('b06e52c5-6635-4642-abe9-61297c878cf9', 'f9b6ce0f-635b-4ba0-961b-39f98ba3fb6b');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('b06e52c5-6635-4642-abe9-61297c878cf9', 'de9e7111-fc7c-4e3c-9462-40c25d524f94');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('b06e52c5-6635-4642-abe9-61297c878cf9', '5ed10474-21bf-40e9-bbb3-f80eab73baaa');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('5104b014-6fe6-4086-8e50-b6038d06f23e', 'f9b6ce0f-635b-4ba0-961b-39f98ba3fb6b');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('5104b014-6fe6-4086-8e50-b6038d06f23e', 'de9e7111-fc7c-4e3c-9462-40c25d524f94');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('5104b014-6fe6-4086-8e50-b6038d06f23e', '5ed10474-21bf-40e9-bbb3-f80eab73baaa');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('fbc29587-fcba-4b81-b8f4-4c36313aeab7', 'f9b6ce0f-635b-4ba0-961b-39f98ba3fb6b');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('fbc29587-fcba-4b81-b8f4-4c36313aeab7', 'de9e7111-fc7c-4e3c-9462-40c25d524f94');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('fbc29587-fcba-4b81-b8f4-4c36313aeab7', '5ed10474-21bf-40e9-bbb3-f80eab73baaa');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('67007f3b-7afc-4e4a-99c3-7953f2b5977a', 'f9b6ce0f-635b-4ba0-961b-39f98ba3fb6b');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('67007f3b-7afc-4e4a-99c3-7953f2b5977a', 'de9e7111-fc7c-4e3c-9462-40c25d524f94');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('e6115285-34ec-4fa2-a088-3003ab8ba657', 'f9b6ce0f-635b-4ba0-961b-39f98ba3fb6b');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('e6115285-34ec-4fa2-a088-3003ab8ba657', 'de9e7111-fc7c-4e3c-9462-40c25d524f94');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('fb9c26ce-060c-4dc5-a7b8-45ac7b6bfa4f', 'f9b6ce0f-635b-4ba0-961b-39f98ba3fb6b');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('fb9c26ce-060c-4dc5-a7b8-45ac7b6bfa4f', 'de9e7111-fc7c-4e3c-9462-40c25d524f94');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('19bcdfb7-989c-4daf-a9ca-6b5e8951b97b', 'f9b6ce0f-635b-4ba0-961b-39f98ba3fb6b');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('19bcdfb7-989c-4daf-a9ca-6b5e8951b97b', 'de9e7111-fc7c-4e3c-9462-40c25d524f94');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('5cf293bc-e1a9-479a-b503-561e0fa99fc6', 'f9b6ce0f-635b-4ba0-961b-39f98ba3fb6b');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('5cf293bc-e1a9-479a-b503-561e0fa99fc6', 'de9e7111-fc7c-4e3c-9462-40c25d524f94');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('9391162c-e6ba-48fd-99bd-31c1ef627695', 'f9b6ce0f-635b-4ba0-961b-39f98ba3fb6b');
INSERT INTO public.associated_policy (policy_id, associated_policy_id) VALUES ('9391162c-e6ba-48fd-99bd-31c1ef627695', 'de9e7111-fc7c-4e3c-9462-40c25d524f94');


--
-- TOC entry 4142 (class 0 OID 16394)
-- Dependencies: 216
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('5d10087a-84a6-480d-9bf6-587d1a8b0297', NULL, 'auth-cookie', 'master', '02a7a345-5110-4c64-8df0-2d9addfd51ff', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('e06a9bb1-8076-435a-a8fb-9d114cd8b6fc', NULL, 'auth-spnego', 'master', '02a7a345-5110-4c64-8df0-2d9addfd51ff', 3, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('598000f7-29ff-4321-8ab9-dc9851777c75', NULL, 'identity-provider-redirector', 'master', '02a7a345-5110-4c64-8df0-2d9addfd51ff', 2, 25, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('983f2456-8dae-451c-8563-b9dcc6a4f4b0', NULL, NULL, 'master', '02a7a345-5110-4c64-8df0-2d9addfd51ff', 2, 30, true, '27898167-c15d-4d6f-a4fc-cd32ee9b7044', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('ee3f1920-b685-44b4-ab2b-218c85386bdd', NULL, 'auth-username-password-form', 'master', '27898167-c15d-4d6f-a4fc-cd32ee9b7044', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('83aa0ce9-8da0-4f41-bd41-58416b5c10f3', NULL, NULL, 'master', '27898167-c15d-4d6f-a4fc-cd32ee9b7044', 1, 20, true, '9e126f23-e97b-49a9-baef-ef4ea3bd1a3c', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('4ed0ead1-3b8b-4592-b832-63369ceb70ea', NULL, 'conditional-user-configured', 'master', '9e126f23-e97b-49a9-baef-ef4ea3bd1a3c', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('f997b3f8-7707-4e88-94e1-a5e85dc2de4c', NULL, 'auth-otp-form', 'master', '9e126f23-e97b-49a9-baef-ef4ea3bd1a3c', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('b1af6584-9d10-40ad-b1fe-7de4b9e41285', NULL, 'direct-grant-validate-username', 'master', '0815a0bb-70ea-4e94-8cc5-73be5819025c', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('c4c90492-521a-4450-b0b5-2609fc5b4883', NULL, 'direct-grant-validate-password', 'master', '0815a0bb-70ea-4e94-8cc5-73be5819025c', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('28f16fd6-b0c7-4d3f-bc8d-aeedeeab61f6', NULL, NULL, 'master', '0815a0bb-70ea-4e94-8cc5-73be5819025c', 1, 30, true, 'ce895f6b-bd6d-4061-afee-6f729ae7102b', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('c627c602-3d88-4f67-ae19-0d50fb213a9f', NULL, 'conditional-user-configured', 'master', 'ce895f6b-bd6d-4061-afee-6f729ae7102b', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('d023ce5b-e257-4305-b9b7-3c62f094a968', NULL, 'direct-grant-validate-otp', 'master', 'ce895f6b-bd6d-4061-afee-6f729ae7102b', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('81b7aa9f-79b5-4b42-85dd-bd950df38c97', NULL, 'registration-page-form', 'master', '1a3ed8f3-63e4-4d44-8684-7b869d4abe87', 0, 10, true, '7d29bbfe-6d87-46f3-8d00-a1c1d446ad68', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('1674650a-483c-425e-abfa-949979347753', NULL, 'registration-user-creation', 'master', '7d29bbfe-6d87-46f3-8d00-a1c1d446ad68', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('d4b9e469-2bc5-4384-9cc2-a8c88ff36e94', NULL, 'registration-profile-action', 'master', '7d29bbfe-6d87-46f3-8d00-a1c1d446ad68', 0, 40, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('aadc096f-3c17-411f-9531-c8b38345739c', NULL, 'registration-password-action', 'master', '7d29bbfe-6d87-46f3-8d00-a1c1d446ad68', 0, 50, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('77e5bd75-febd-4b92-a688-d194ebe7d7a0', NULL, 'registration-recaptcha-action', 'master', '7d29bbfe-6d87-46f3-8d00-a1c1d446ad68', 3, 60, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('fea67dc8-f664-4d6c-b459-b9f993c9e889', NULL, 'reset-credentials-choose-user', 'master', '54bc9586-79fb-423c-8c10-2f7b5c415745', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('2aec8b8c-ad25-4364-8e37-08734a3915a2', NULL, 'reset-credential-email', 'master', '54bc9586-79fb-423c-8c10-2f7b5c415745', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('73aa9ed5-e01e-4fc6-b1a9-0f91bcc3762f', NULL, 'reset-password', 'master', '54bc9586-79fb-423c-8c10-2f7b5c415745', 0, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('4e850ba7-f545-4344-936e-50cc4059e5cd', NULL, NULL, 'master', '54bc9586-79fb-423c-8c10-2f7b5c415745', 1, 40, true, '94b0b86b-eb37-4c5b-9a76-73555c4a6458', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('6664f077-5bbb-43ca-8b4a-fe3f107ba14d', NULL, 'conditional-user-configured', 'master', '94b0b86b-eb37-4c5b-9a76-73555c4a6458', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('7a3bc44f-3a94-4219-b66f-7f80fe8e0239', NULL, 'reset-otp', 'master', '94b0b86b-eb37-4c5b-9a76-73555c4a6458', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('e07c0bc6-74d7-41a0-973c-af9f9bb49559', NULL, 'client-secret', 'master', '8e83faae-a002-4b5f-8c80-c8e0dfc2f527', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('1369f7cb-bb3e-40a0-b8cb-952cc5a0b67c', NULL, 'client-jwt', 'master', '8e83faae-a002-4b5f-8c80-c8e0dfc2f527', 2, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('e897380d-aa56-48d4-b477-10ee7b1a230f', NULL, 'client-secret-jwt', 'master', '8e83faae-a002-4b5f-8c80-c8e0dfc2f527', 2, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('54003f75-1673-4376-a61b-8eb77b81a722', NULL, 'client-x509', 'master', '8e83faae-a002-4b5f-8c80-c8e0dfc2f527', 2, 40, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('dbc8221e-83d4-459e-951d-dac149468e40', NULL, 'idp-review-profile', 'master', '727694fd-f591-4777-9f5f-08efcb602de9', 0, 10, false, NULL, 'e11c6b1e-430c-43c1-b109-1f092d9e1304');
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('4ad531e3-ce78-4db1-972b-0745ef67654b', NULL, NULL, 'master', '727694fd-f591-4777-9f5f-08efcb602de9', 0, 20, true, 'd25f4a8f-a1b9-4497-9666-d51159d9be2a', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('bfdec415-c807-4013-aabe-610ce4241a7e', NULL, 'idp-create-user-if-unique', 'master', 'd25f4a8f-a1b9-4497-9666-d51159d9be2a', 2, 10, false, NULL, '3ddb3e83-9cf1-4c07-bf52-2a8561a1341c');
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('c570dc16-a96b-423f-bf27-77be38070499', NULL, NULL, 'master', 'd25f4a8f-a1b9-4497-9666-d51159d9be2a', 2, 20, true, 'f65b1dbb-381e-45e6-9889-369adffd003b', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('738619c2-44ca-4bb4-8e3b-8d1ca5faeb12', NULL, 'idp-confirm-link', 'master', 'f65b1dbb-381e-45e6-9889-369adffd003b', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('30fd8bbb-7613-4c3e-a20b-1cd6204f754e', NULL, NULL, 'master', 'f65b1dbb-381e-45e6-9889-369adffd003b', 0, 20, true, 'd9891ae3-1cf3-42f2-a95a-0f4f3407af16', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('9258b8e1-050b-4ad9-86bd-01b1a43a2f2d', NULL, 'idp-email-verification', 'master', 'd9891ae3-1cf3-42f2-a95a-0f4f3407af16', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('74539a2e-ff9a-4e81-8f19-c02805b2191e', NULL, NULL, 'master', 'd9891ae3-1cf3-42f2-a95a-0f4f3407af16', 2, 20, true, '5b07be74-7032-439b-9f4f-1c22473e74b1', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('102f0d2a-4124-4a8b-aed0-551dc18d2fe1', NULL, 'idp-username-password-form', 'master', '5b07be74-7032-439b-9f4f-1c22473e74b1', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('084cb89d-27c9-415f-a36f-f64eaaaee667', NULL, NULL, 'master', '5b07be74-7032-439b-9f4f-1c22473e74b1', 1, 20, true, 'c854bfdf-b469-411a-99d4-093876b794ae', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('1648d39f-1fa3-4bf4-94b9-7c3512b0c653', NULL, 'conditional-user-configured', 'master', 'c854bfdf-b469-411a-99d4-093876b794ae', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('845f1121-7ae0-4b86-b813-8610a557ece8', NULL, 'auth-otp-form', 'master', 'c854bfdf-b469-411a-99d4-093876b794ae', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('0cdada66-e536-4e4e-93c4-ea3b0cb202f7', NULL, 'http-basic-authenticator', 'master', '8f6984d4-cd52-45b5-89ba-7e9d550a52ae', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('b477fbfc-360c-4b09-ac13-63a4a4e58817', NULL, 'docker-http-basic-authenticator', 'master', '479c3659-8b02-4d4e-95fb-b1b17866b4e2', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('fa14ab32-92bb-4812-bcab-177e9d74bf2b', NULL, 'no-cookie-redirect', 'master', '719e8904-edd5-46e0-badf-395e6df79eb5', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('d22a9e75-9c36-44cf-8a80-6afde9c49c2e', NULL, NULL, 'master', '719e8904-edd5-46e0-badf-395e6df79eb5', 0, 20, true, '730c846f-59b6-48a0-9469-b6e72273bcf9', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('63d5e6bc-5bc7-46a4-bc7d-947897d20241', NULL, 'basic-auth', 'master', '730c846f-59b6-48a0-9469-b6e72273bcf9', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('0f4c4469-247a-439d-a058-f9c0e95129a0', NULL, 'basic-auth-otp', 'master', '730c846f-59b6-48a0-9469-b6e72273bcf9', 3, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('99a76ce2-0926-4dc6-8022-d04b828fd504', NULL, 'auth-spnego', 'master', '730c846f-59b6-48a0-9469-b6e72273bcf9', 3, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('d6e31af9-fffc-4383-9068-4526de3fc430', NULL, 'auth-cookie', 'clin', '9e5b0ebc-0a50-4175-a789-b6109310f54d', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('35cd5f3f-f565-4c3a-881d-1d32ed9ed223', NULL, 'auth-spnego', 'clin', '9e5b0ebc-0a50-4175-a789-b6109310f54d', 3, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('d9bf4344-d7b7-4bca-86ba-7aaf3ce80d50', NULL, 'identity-provider-redirector', 'clin', '9e5b0ebc-0a50-4175-a789-b6109310f54d', 2, 25, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('aa5a09c8-2b94-4e52-bde0-778c446eea1f', NULL, NULL, 'clin', '9e5b0ebc-0a50-4175-a789-b6109310f54d', 2, 30, true, '6a9bd083-548a-46bb-9a6e-b99fb7e621c9', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('0884790e-429f-45fd-adf8-033b08f22636', NULL, 'auth-username-password-form', 'clin', '6a9bd083-548a-46bb-9a6e-b99fb7e621c9', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('b3451d21-af4e-40f0-829d-48c051b7b42c', NULL, NULL, 'clin', '6a9bd083-548a-46bb-9a6e-b99fb7e621c9', 1, 20, true, '11ea726c-acf6-4f48-bcc4-b8d1197604ea', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('7a449766-43fd-4fdb-84fe-4fcbcb5eba22', NULL, 'conditional-user-configured', 'clin', '11ea726c-acf6-4f48-bcc4-b8d1197604ea', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('9d573ff1-fce6-4543-a1ff-8f3f473215b0', NULL, 'auth-otp-form', 'clin', '11ea726c-acf6-4f48-bcc4-b8d1197604ea', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('c42d9582-63f3-404a-848e-55f5c8aa593f', NULL, 'direct-grant-validate-username', 'clin', '638fa959-472b-4374-836b-7470570fdf3a', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('3ed7ada2-5c68-4519-b7c5-97ab22ba28ec', NULL, 'direct-grant-validate-password', 'clin', '638fa959-472b-4374-836b-7470570fdf3a', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('de331a14-41a5-4452-8b94-5365d90593ee', NULL, NULL, 'clin', '638fa959-472b-4374-836b-7470570fdf3a', 1, 30, true, 'c8098a82-8790-4320-b2be-8d7c8c1da84c', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('69d2f789-f80a-41bb-a10a-403088e1901c', NULL, 'conditional-user-configured', 'clin', 'c8098a82-8790-4320-b2be-8d7c8c1da84c', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('cb3a28a6-9c99-441c-83da-c7c81b34264a', NULL, 'direct-grant-validate-otp', 'clin', 'c8098a82-8790-4320-b2be-8d7c8c1da84c', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('6bbb4dd6-560f-4472-8c27-f70c7eddc112', NULL, 'registration-page-form', 'clin', '596c20e0-8f0c-4ae2-a8e8-4a10ae5ad88e', 0, 10, true, 'fdf38699-8f2a-4ca4-aa64-8ec4d2c1ddd4', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('5e13ee6f-f415-4350-9b56-ef694027dcad', NULL, 'registration-user-creation', 'clin', 'fdf38699-8f2a-4ca4-aa64-8ec4d2c1ddd4', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('25d47ef0-e59a-4ffa-a46d-d6842accb598', NULL, 'registration-profile-action', 'clin', 'fdf38699-8f2a-4ca4-aa64-8ec4d2c1ddd4', 0, 40, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('b43a5d52-8821-484e-a5c1-305333b7f9a0', NULL, 'registration-password-action', 'clin', 'fdf38699-8f2a-4ca4-aa64-8ec4d2c1ddd4', 0, 50, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('d8a7651d-febd-496c-b263-e4248fbe7cbe', NULL, 'registration-recaptcha-action', 'clin', 'fdf38699-8f2a-4ca4-aa64-8ec4d2c1ddd4', 3, 60, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('f7275951-5771-419e-af2f-db65501dfa5a', NULL, 'reset-credentials-choose-user', 'clin', '42db2e1b-ae9a-4de2-86f3-46715677c7d4', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('ac8dc606-16c9-47de-a8fb-bd0e0ee739aa', NULL, 'reset-credential-email', 'clin', '42db2e1b-ae9a-4de2-86f3-46715677c7d4', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('850ee18f-414a-4b1a-a821-042c3b8484b9', NULL, 'reset-password', 'clin', '42db2e1b-ae9a-4de2-86f3-46715677c7d4', 0, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('d6e67a98-59a9-45f7-ba3d-ba970463ee6e', NULL, NULL, 'clin', '42db2e1b-ae9a-4de2-86f3-46715677c7d4', 1, 40, true, 'e68a5a96-b6a9-4b27-8dee-8c226e2920a5', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('634419c5-16a4-4abf-a7ac-3580793cab8c', NULL, 'conditional-user-configured', 'clin', 'e68a5a96-b6a9-4b27-8dee-8c226e2920a5', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('f077cd76-4b69-4a31-b80b-aa56b93416ad', NULL, 'reset-otp', 'clin', 'e68a5a96-b6a9-4b27-8dee-8c226e2920a5', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('43c412cf-9551-4617-bb6e-5da4bf66571f', NULL, 'client-secret', 'clin', 'd3c1ae89-04cb-4a47-a49c-4ebf8bee18f0', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('c73fe5b6-18da-4b93-9f77-06dbf90e7fe2', NULL, 'client-jwt', 'clin', 'd3c1ae89-04cb-4a47-a49c-4ebf8bee18f0', 2, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('fb5092de-a931-47de-9948-82cbc33b5c5f', NULL, 'client-secret-jwt', 'clin', 'd3c1ae89-04cb-4a47-a49c-4ebf8bee18f0', 2, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('4824963f-a9d2-4a3f-8558-3c5fd630e990', NULL, 'client-x509', 'clin', 'd3c1ae89-04cb-4a47-a49c-4ebf8bee18f0', 2, 40, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('788211c1-8c3a-4c39-b0c2-020c21acb834', NULL, 'idp-review-profile', 'clin', 'b5d6b50b-cacf-4d4d-b80a-48cfe571edcb', 0, 10, false, NULL, '4e4b27f7-c666-4d35-bf37-619b875cab41');
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('44958228-4a6d-4af1-aad5-9d80a792b286', NULL, NULL, 'clin', 'b5d6b50b-cacf-4d4d-b80a-48cfe571edcb', 0, 20, true, '26f96442-5aa2-4900-a51b-9f76a84dcfbe', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('a9306b59-3fb9-4e4d-9da7-71f65d951a20', NULL, 'idp-create-user-if-unique', 'clin', '26f96442-5aa2-4900-a51b-9f76a84dcfbe', 2, 10, false, NULL, 'cad12d0c-798e-400f-b02b-406bf2c721b9');
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('b19b8e02-217d-42ae-a4a2-d1d1301db82f', NULL, NULL, 'clin', '26f96442-5aa2-4900-a51b-9f76a84dcfbe', 2, 20, true, '26ba5ac5-0e88-4ac5-bd8d-d37ffb30a5e5', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('26882673-9190-4824-b553-8040a0b6ab67', NULL, 'idp-confirm-link', 'clin', '26ba5ac5-0e88-4ac5-bd8d-d37ffb30a5e5', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('84d4d13a-b291-4335-a893-600606538f02', NULL, NULL, 'clin', '26ba5ac5-0e88-4ac5-bd8d-d37ffb30a5e5', 0, 20, true, '3d6f40c3-5cad-48c5-b4e1-3c1c5a0d674a', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('eb140b73-17b7-4ba1-9b97-49aae7c0f84f', NULL, 'idp-email-verification', 'clin', '3d6f40c3-5cad-48c5-b4e1-3c1c5a0d674a', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('ca988aa9-37a3-4c67-adda-094880047df6', NULL, NULL, 'clin', '3d6f40c3-5cad-48c5-b4e1-3c1c5a0d674a', 2, 20, true, 'c1a31a6b-32ee-433b-a697-f060b63ce148', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('b0075b13-8397-4ccf-b16e-a09e808a6f8b', NULL, 'idp-username-password-form', 'clin', 'c1a31a6b-32ee-433b-a697-f060b63ce148', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('ab6943c0-16c0-4b77-aea9-2a120576d29c', NULL, NULL, 'clin', 'c1a31a6b-32ee-433b-a697-f060b63ce148', 1, 20, true, '74e3a913-43d3-4c08-8ade-931aac4a6e52', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('84926c3a-e6bf-43e9-970a-d9f881c30a17', NULL, 'conditional-user-configured', 'clin', '74e3a913-43d3-4c08-8ade-931aac4a6e52', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('962f8668-d827-4cb0-a367-cb67ada047d2', NULL, 'auth-otp-form', 'clin', '74e3a913-43d3-4c08-8ade-931aac4a6e52', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('7d266fed-be94-456b-810e-0f1aa388c720', NULL, 'http-basic-authenticator', 'clin', 'ba342e8c-6521-4492-a168-3ca482f03497', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('a650e3f5-5f0d-40d1-8c93-535144464277', NULL, 'docker-http-basic-authenticator', 'clin', '18e55257-19ab-4ad5-ba89-7b0d89a5bd80', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('b5b8ae0a-56a8-4bdd-90f1-af79c7a2e607', NULL, 'no-cookie-redirect', 'clin', '8ff7509e-67b3-496c-8abc-8e1da4398fb7', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('bcc26b9e-be62-417e-848c-b7f023b240f7', NULL, NULL, 'clin', '8ff7509e-67b3-496c-8abc-8e1da4398fb7', 0, 20, true, '05a6f6f4-a7e7-415d-b878-91df31f3b67a', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('5e4f13a4-e689-4abf-8a46-664db2b3e91b', NULL, 'basic-auth', 'clin', '05a6f6f4-a7e7-415d-b878-91df31f3b67a', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('0a6093ac-45dc-4289-abe1-7033698c25f4', NULL, 'basic-auth-otp', 'clin', '05a6f6f4-a7e7-415d-b878-91df31f3b67a', 3, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('4741ef32-0d1a-4b9a-8210-2d4972476243', NULL, 'auth-spnego', 'clin', '05a6f6f4-a7e7-415d-b878-91df31f3b67a', 3, 30, false, NULL, NULL);


--
-- TOC entry 4143 (class 0 OID 16398)
-- Dependencies: 217
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('02a7a345-5110-4c64-8df0-2d9addfd51ff', 'browser', 'browser based authentication', 'master', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('27898167-c15d-4d6f-a4fc-cd32ee9b7044', 'forms', 'Username, password, otp and other auth forms.', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('9e126f23-e97b-49a9-baef-ef4ea3bd1a3c', 'Browser - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('0815a0bb-70ea-4e94-8cc5-73be5819025c', 'direct grant', 'OpenID Connect Resource Owner Grant', 'master', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('ce895f6b-bd6d-4061-afee-6f729ae7102b', 'Direct Grant - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('1a3ed8f3-63e4-4d44-8684-7b869d4abe87', 'registration', 'registration flow', 'master', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('7d29bbfe-6d87-46f3-8d00-a1c1d446ad68', 'registration form', 'registration form', 'master', 'form-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('54bc9586-79fb-423c-8c10-2f7b5c415745', 'reset credentials', 'Reset credentials for a user if they forgot their password or something', 'master', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('94b0b86b-eb37-4c5b-9a76-73555c4a6458', 'Reset - Conditional OTP', 'Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('8e83faae-a002-4b5f-8c80-c8e0dfc2f527', 'clients', 'Base authentication for clients', 'master', 'client-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('727694fd-f591-4777-9f5f-08efcb602de9', 'first broker login', 'Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account', 'master', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('d25f4a8f-a1b9-4497-9666-d51159d9be2a', 'User creation or linking', 'Flow for the existing/non-existing user alternatives', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('f65b1dbb-381e-45e6-9889-369adffd003b', 'Handle Existing Account', 'Handle what to do if there is existing account with same email/username like authenticated identity provider', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('d9891ae3-1cf3-42f2-a95a-0f4f3407af16', 'Account verification options', 'Method with which to verity the existing account', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('5b07be74-7032-439b-9f4f-1c22473e74b1', 'Verify Existing Account by Re-authentication', 'Reauthentication of existing account', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('c854bfdf-b469-411a-99d4-093876b794ae', 'First broker login - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('8f6984d4-cd52-45b5-89ba-7e9d550a52ae', 'saml ecp', 'SAML ECP Profile Authentication Flow', 'master', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('479c3659-8b02-4d4e-95fb-b1b17866b4e2', 'docker auth', 'Used by Docker clients to authenticate against the IDP', 'master', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('719e8904-edd5-46e0-badf-395e6df79eb5', 'http challenge', 'An authentication flow based on challenge-response HTTP Authentication Schemes', 'master', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('730c846f-59b6-48a0-9469-b6e72273bcf9', 'Authentication Options', 'Authentication options.', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('9e5b0ebc-0a50-4175-a789-b6109310f54d', 'browser', 'browser based authentication', 'clin', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('6a9bd083-548a-46bb-9a6e-b99fb7e621c9', 'forms', 'Username, password, otp and other auth forms.', 'clin', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('11ea726c-acf6-4f48-bcc4-b8d1197604ea', 'Browser - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'clin', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('638fa959-472b-4374-836b-7470570fdf3a', 'direct grant', 'OpenID Connect Resource Owner Grant', 'clin', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('c8098a82-8790-4320-b2be-8d7c8c1da84c', 'Direct Grant - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'clin', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('596c20e0-8f0c-4ae2-a8e8-4a10ae5ad88e', 'registration', 'registration flow', 'clin', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('fdf38699-8f2a-4ca4-aa64-8ec4d2c1ddd4', 'registration form', 'registration form', 'clin', 'form-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('42db2e1b-ae9a-4de2-86f3-46715677c7d4', 'reset credentials', 'Reset credentials for a user if they forgot their password or something', 'clin', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('e68a5a96-b6a9-4b27-8dee-8c226e2920a5', 'Reset - Conditional OTP', 'Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.', 'clin', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('d3c1ae89-04cb-4a47-a49c-4ebf8bee18f0', 'clients', 'Base authentication for clients', 'clin', 'client-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('b5d6b50b-cacf-4d4d-b80a-48cfe571edcb', 'first broker login', 'Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account', 'clin', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('26f96442-5aa2-4900-a51b-9f76a84dcfbe', 'User creation or linking', 'Flow for the existing/non-existing user alternatives', 'clin', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('26ba5ac5-0e88-4ac5-bd8d-d37ffb30a5e5', 'Handle Existing Account', 'Handle what to do if there is existing account with same email/username like authenticated identity provider', 'clin', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('3d6f40c3-5cad-48c5-b4e1-3c1c5a0d674a', 'Account verification options', 'Method with which to verity the existing account', 'clin', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('c1a31a6b-32ee-433b-a697-f060b63ce148', 'Verify Existing Account by Re-authentication', 'Reauthentication of existing account', 'clin', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('74e3a913-43d3-4c08-8ade-931aac4a6e52', 'First broker login - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'clin', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('ba342e8c-6521-4492-a168-3ca482f03497', 'saml ecp', 'SAML ECP Profile Authentication Flow', 'clin', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('18e55257-19ab-4ad5-ba89-7b0d89a5bd80', 'docker auth', 'Used by Docker clients to authenticate against the IDP', 'clin', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('8ff7509e-67b3-496c-8abc-8e1da4398fb7', 'http challenge', 'An authentication flow based on challenge-response HTTP Authentication Schemes', 'clin', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('05a6f6f4-a7e7-415d-b878-91df31f3b67a', 'Authentication Options', 'Authentication options.', 'clin', 'basic-flow', false, true);


--
-- TOC entry 4144 (class 0 OID 16406)
-- Dependencies: 218
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.authenticator_config (id, alias, realm_id) VALUES ('e11c6b1e-430c-43c1-b109-1f092d9e1304', 'review profile config', 'master');
INSERT INTO public.authenticator_config (id, alias, realm_id) VALUES ('3ddb3e83-9cf1-4c07-bf52-2a8561a1341c', 'create unique user config', 'master');
INSERT INTO public.authenticator_config (id, alias, realm_id) VALUES ('4e4b27f7-c666-4d35-bf37-619b875cab41', 'review profile config', 'clin');
INSERT INTO public.authenticator_config (id, alias, realm_id) VALUES ('cad12d0c-798e-400f-b02b-406bf2c721b9', 'create unique user config', 'clin');


--
-- TOC entry 4145 (class 0 OID 16409)
-- Dependencies: 219
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.authenticator_config_entry (authenticator_id, value, name) VALUES ('e11c6b1e-430c-43c1-b109-1f092d9e1304', 'missing', 'update.profile.on.first.login');
INSERT INTO public.authenticator_config_entry (authenticator_id, value, name) VALUES ('3ddb3e83-9cf1-4c07-bf52-2a8561a1341c', 'false', 'require.password.update.after.registration');
INSERT INTO public.authenticator_config_entry (authenticator_id, value, name) VALUES ('4e4b27f7-c666-4d35-bf37-619b875cab41', 'missing', 'update.profile.on.first.login');
INSERT INTO public.authenticator_config_entry (authenticator_id, value, name) VALUES ('cad12d0c-798e-400f-b02b-406bf2c721b9', 'false', 'require.password.update.after.registration');


--
-- TOC entry 4146 (class 0 OID 16414)
-- Dependencies: 220
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4147 (class 0 OID 16419)
-- Dependencies: 221
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('666fea7e-1491-48d3-83ac-229faaaa9aa6', true, true, 'master-realm', 0, false, 'd3835fcf-adc9-42cd-aa14-0962b9becd5f', NULL, true, NULL, false, 'master', NULL, 0, false, false, 'master Realm', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('740d7d62-c828-439b-a4c0-6f513354894a', true, false, 'account', 0, false, 'd39faee6-253f-4435-8dd4-979129bb7951', '/realms/master/account/', false, NULL, false, 'master', 'openid-connect', 0, false, false, '${client_account}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('0fc80003-6ce5-46c2-a047-1d0e44291402', true, false, 'account-console', 0, true, 'b0a002df-be3a-4837-99a9-f76bf49d961d', '/realms/master/account/', false, NULL, false, 'master', 'openid-connect', 0, false, false, '${client_account-console}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('9fd6733e-200a-4f4a-bcbc-aad28d5a919a', true, false, 'broker', 0, false, '79baba4e-f9e9-45d7-a6d2-4bc58a047543', NULL, false, NULL, false, 'master', 'openid-connect', 0, false, false, '${client_broker}', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('21967484-d12e-48b0-8a2d-acc885559c01', true, false, 'security-admin-console', 0, true, '5de3b87a-fba5-477c-adc5-5ff3bc9b7494', '/admin/master/console/', false, NULL, false, 'master', 'openid-connect', 0, false, false, '${client_security-admin-console}', false, 'client-secret', '${authAdminUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('ea668f5b-d4e0-415e-962b-a241c6374ecf', true, false, 'admin-cli', 0, true, 'f13be918-4145-4fdf-958a-80775f563adc', NULL, false, NULL, false, 'master', 'openid-connect', 0, false, false, '${client_admin-cli}', false, 'client-secret', NULL, NULL, NULL, false, false, true, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', true, true, 'clin-realm', 0, false, '0a44dbba-30d1-4baf-bc42-3c940cf72e55', NULL, true, NULL, false, 'master', NULL, 0, false, false, 'clin Realm', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('8271513b-5e8c-4b3b-9374-5c477d2010a0', true, false, 'realm-management', 0, false, '858145fe-2f06-413f-b4aa-506b04f16ef0', NULL, true, NULL, false, 'clin', 'openid-connect', 0, false, false, '${client_realm-management}', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('f7af93f2-37c5-4cf6-b07e-7b6620cf8458', true, false, 'account', 0, false, 'fc5722dc-d54e-4513-88d1-01283b67d28e', '/realms/clin/account/', false, NULL, false, 'clin', 'openid-connect', 0, false, false, '${client_account}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('09e07cd8-2e94-4ce2-acbe-981d5d672371', true, false, 'account-console', 0, true, 'acb499e1-2699-4ad4-af35-59f0f30b56e9', '/realms/clin/account/', false, NULL, false, 'clin', 'openid-connect', 0, false, false, '${client_account-console}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('5d0fab1b-4e20-4c5a-b1bd-017bedd9e3e4', true, false, 'broker', 0, false, 'fc0022cd-37b4-4897-9759-8b7d3a9b672f', NULL, false, NULL, false, 'clin', 'openid-connect', 0, false, false, '${client_broker}', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('78e8963c-3ea0-4eee-b438-237191ebab68', true, false, 'security-admin-console', 0, true, 'd6e64315-af12-4392-8b54-de3b88f34966', '/admin/clin/console/', false, NULL, false, 'clin', 'openid-connect', 0, false, false, '${client_security-admin-console}', false, 'client-secret', '${authAdminUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('e301c57c-ca49-452f-a76d-f9f959656d48', true, false, 'admin-cli', 0, true, '512b3f80-a3ab-4e79-a673-d3c3bf82d969', NULL, false, NULL, false, 'clin', 'openid-connect', 0, false, false, '${client_admin-cli}', false, 'client-secret', NULL, NULL, NULL, false, false, true, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('8f553005-b544-4e27-8fbc-a9a517ed6fe9', true, true, 'clin-system', 0, false, 'e88131f8-756c-42e3-bb10-2ceec133b8bc', NULL, false, NULL, false, 'clin', 'openid-connect', -1, false, false, NULL, true, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', true, true, 'clin-acl', 0, false, '8fc17ce4-6e64-4026-bcb0-6aece296f05b', NULL, false, NULL, false, 'clin', 'openid-connect', -1, false, false, NULL, true, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('df77c1aa-6543-489f-919a-3880f58d5494', true, true, 'clin-client', 0, true, '598d13c3-04fc-42ad-93f6-5a5b0d16004b', NULL, false, NULL, false, 'clin', 'openid-connect', -1, false, false, NULL, false, 'client-secret', NULL, NULL, NULL, true, false, true, false);


--
-- TOC entry 4148 (class 0 OID 16437)
-- Dependencies: 222
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.client_attributes (client_id, value, name) VALUES ('0fc80003-6ce5-46c2-a047-1d0e44291402', 'S256', 'pkce.code.challenge.method');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('21967484-d12e-48b0-8a2d-acc885559c01', 'S256', 'pkce.code.challenge.method');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('09e07cd8-2e94-4ce2-acbe-981d5d672371', 'S256', 'pkce.code.challenge.method');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('78e8963c-3ea0-4eee-b438-237191ebab68', 'S256', 'pkce.code.challenge.method');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('8f553005-b544-4e27-8fbc-a9a517ed6fe9', 'true', 'backchannel.logout.session.required');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('8f553005-b544-4e27-8fbc-a9a517ed6fe9', 'false', 'backchannel.logout.revoke.offline.tokens');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('8f553005-b544-4e27-8fbc-a9a517ed6fe9', NULL, 'request.uris');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('8f553005-b544-4e27-8fbc-a9a517ed6fe9', 'false', 'saml.server.signature');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('8f553005-b544-4e27-8fbc-a9a517ed6fe9', 'false', 'saml.server.signature.keyinfo.ext');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('8f553005-b544-4e27-8fbc-a9a517ed6fe9', 'false', 'saml.assertion.signature');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('8f553005-b544-4e27-8fbc-a9a517ed6fe9', 'false', 'saml.client.signature');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('8f553005-b544-4e27-8fbc-a9a517ed6fe9', 'false', 'saml.encrypt');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('8f553005-b544-4e27-8fbc-a9a517ed6fe9', 'false', 'saml.authnstatement');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('8f553005-b544-4e27-8fbc-a9a517ed6fe9', 'false', 'saml.onetimeuse.condition');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('8f553005-b544-4e27-8fbc-a9a517ed6fe9', 'false', 'saml_force_name_id_format');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('8f553005-b544-4e27-8fbc-a9a517ed6fe9', 'false', 'saml.multivalued.roles');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('8f553005-b544-4e27-8fbc-a9a517ed6fe9', 'false', 'saml.force.post.binding');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('8f553005-b544-4e27-8fbc-a9a517ed6fe9', 'false', 'exclude.session.state.from.auth.response');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('8f553005-b544-4e27-8fbc-a9a517ed6fe9', 'false', 'tls.client.certificate.bound.access.tokens');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('8f553005-b544-4e27-8fbc-a9a517ed6fe9', 'false', 'client_credentials.use_refresh_token');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('8f553005-b544-4e27-8fbc-a9a517ed6fe9', 'false', 'display.on.consent.screen');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', 'true', 'backchannel.logout.session.required');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', 'false', 'backchannel.logout.revoke.offline.tokens');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', NULL, 'request.uris');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', 'false', 'saml.server.signature');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', 'false', 'saml.server.signature.keyinfo.ext');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', 'false', 'saml.assertion.signature');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', 'false', 'saml.client.signature');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', 'false', 'saml.encrypt');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', 'false', 'saml.authnstatement');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', 'false', 'saml.onetimeuse.condition');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', 'false', 'saml_force_name_id_format');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', 'false', 'saml.multivalued.roles');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', 'false', 'saml.force.post.binding');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', 'false', 'exclude.session.state.from.auth.response');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', 'false', 'tls.client.certificate.bound.access.tokens');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', 'false', 'client_credentials.use_refresh_token');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', 'false', 'display.on.consent.screen');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('df77c1aa-6543-489f-919a-3880f58d5494', 'true', 'backchannel.logout.session.required');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('df77c1aa-6543-489f-919a-3880f58d5494', 'false', 'backchannel.logout.revoke.offline.tokens');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('df77c1aa-6543-489f-919a-3880f58d5494', NULL, 'request.uris');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('df77c1aa-6543-489f-919a-3880f58d5494', 'false', 'saml.server.signature');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('df77c1aa-6543-489f-919a-3880f58d5494', 'false', 'saml.server.signature.keyinfo.ext');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('df77c1aa-6543-489f-919a-3880f58d5494', 'false', 'saml.assertion.signature');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('df77c1aa-6543-489f-919a-3880f58d5494', 'false', 'saml.client.signature');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('df77c1aa-6543-489f-919a-3880f58d5494', 'false', 'saml.encrypt');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('df77c1aa-6543-489f-919a-3880f58d5494', 'false', 'saml.authnstatement');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('df77c1aa-6543-489f-919a-3880f58d5494', 'false', 'saml.onetimeuse.condition');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('df77c1aa-6543-489f-919a-3880f58d5494', 'false', 'saml_force_name_id_format');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('df77c1aa-6543-489f-919a-3880f58d5494', 'false', 'saml.multivalued.roles');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('df77c1aa-6543-489f-919a-3880f58d5494', 'false', 'saml.force.post.binding');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('df77c1aa-6543-489f-919a-3880f58d5494', 'false', 'exclude.session.state.from.auth.response');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('df77c1aa-6543-489f-919a-3880f58d5494', 'false', 'tls.client.certificate.bound.access.tokens');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('df77c1aa-6543-489f-919a-3880f58d5494', 'false', 'client_credentials.use_refresh_token');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('df77c1aa-6543-489f-919a-3880f58d5494', 'false', 'display.on.consent.screen');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('8f553005-b544-4e27-8fbc-a9a517ed6fe9', '3600', 'access.token.lifespan');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', '3600', 'access.token.lifespan');


--
-- TOC entry 4149 (class 0 OID 16442)
-- Dependencies: 223
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4150 (class 0 OID 16445)
-- Dependencies: 224
-- Data for Name: client_default_roles; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.client_default_roles (client_id, role_id) VALUES ('740d7d62-c828-439b-a4c0-6f513354894a', '3df37bdc-beff-4411-bfca-db07a16215f8');
INSERT INTO public.client_default_roles (client_id, role_id) VALUES ('740d7d62-c828-439b-a4c0-6f513354894a', 'd31a5d16-be94-4795-a857-8933093fb18e');
INSERT INTO public.client_default_roles (client_id, role_id) VALUES ('f7af93f2-37c5-4cf6-b07e-7b6620cf8458', '8225db5a-8cb6-4040-ad0d-337d689207da');
INSERT INTO public.client_default_roles (client_id, role_id) VALUES ('f7af93f2-37c5-4cf6-b07e-7b6620cf8458', '43d9eeda-d8c0-46e2-bc15-1b7049bd3824');


--
-- TOC entry 4151 (class 0 OID 16448)
-- Dependencies: 225
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4152 (class 0 OID 16451)
-- Dependencies: 226
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4153 (class 0 OID 16454)
-- Dependencies: 227
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('f49b1a89-50cf-49d5-a83a-f0114459f367', 'offline_access', 'master', 'OpenID Connect built-in scope: offline_access', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('86ff35aa-e6a2-4eae-85e6-cbe8861a9c2e', 'role_list', 'master', 'SAML role list', 'saml');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('f141d59d-1c7a-49d8-a3ce-566db1a2d612', 'profile', 'master', 'OpenID Connect built-in scope: profile', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('50d34770-cf89-4dd0-90c3-81f216bcb84f', 'email', 'master', 'OpenID Connect built-in scope: email', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('3d130846-07fd-49e3-8977-58ce8f3db9ca', 'address', 'master', 'OpenID Connect built-in scope: address', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('2fd3e2bf-b67f-498d-97f9-7ec9b2cd01ae', 'phone', 'master', 'OpenID Connect built-in scope: phone', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('4f187629-96c5-4696-9817-e23d18019241', 'roles', 'master', 'OpenID Connect scope for add user roles to the access token', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('8f3eca4b-2621-407b-8499-4e00b57caae8', 'web-origins', 'master', 'OpenID Connect scope for add allowed web origins to the access token', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('6747b15d-6950-4e9e-992a-fce71215ad12', 'microprofile-jwt', 'master', 'Microprofile - JWT built-in scope', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('a0093c54-0826-4666-9557-3233e6be7ff7', 'offline_access', 'clin', 'OpenID Connect built-in scope: offline_access', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('1bc050b5-b982-4107-8b55-3500654c5426', 'role_list', 'clin', 'SAML role list', 'saml');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('ff25c7ed-164d-4556-85d9-193193c025ca', 'profile', 'clin', 'OpenID Connect built-in scope: profile', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('85f5d4de-1159-4385-b47a-2624724fb2cf', 'email', 'clin', 'OpenID Connect built-in scope: email', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('72f04a91-426c-4691-bddb-58ced7f53b0a', 'address', 'clin', 'OpenID Connect built-in scope: address', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('614d16e8-4c8f-4a48-a1d1-91d0bf237195', 'phone', 'clin', 'OpenID Connect built-in scope: phone', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('fd7a4932-739c-46c2-93d3-c43e3d3b4a22', 'roles', 'clin', 'OpenID Connect scope for add user roles to the access token', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('5469a308-5768-474c-9ab6-39e98a21b841', 'web-origins', 'clin', 'OpenID Connect scope for add allowed web origins to the access token', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('11938e7f-466f-4e38-8e1b-dcd01f70a0fd', 'microprofile-jwt', 'clin', 'Microprofile - JWT built-in scope', 'openid-connect');


--
-- TOC entry 4154 (class 0 OID 16459)
-- Dependencies: 228
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('f49b1a89-50cf-49d5-a83a-f0114459f367', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('f49b1a89-50cf-49d5-a83a-f0114459f367', '${offlineAccessScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('86ff35aa-e6a2-4eae-85e6-cbe8861a9c2e', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('86ff35aa-e6a2-4eae-85e6-cbe8861a9c2e', '${samlRoleListScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('f141d59d-1c7a-49d8-a3ce-566db1a2d612', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('f141d59d-1c7a-49d8-a3ce-566db1a2d612', '${profileScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('f141d59d-1c7a-49d8-a3ce-566db1a2d612', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('50d34770-cf89-4dd0-90c3-81f216bcb84f', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('50d34770-cf89-4dd0-90c3-81f216bcb84f', '${emailScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('50d34770-cf89-4dd0-90c3-81f216bcb84f', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('3d130846-07fd-49e3-8977-58ce8f3db9ca', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('3d130846-07fd-49e3-8977-58ce8f3db9ca', '${addressScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('3d130846-07fd-49e3-8977-58ce8f3db9ca', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('2fd3e2bf-b67f-498d-97f9-7ec9b2cd01ae', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('2fd3e2bf-b67f-498d-97f9-7ec9b2cd01ae', '${phoneScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('2fd3e2bf-b67f-498d-97f9-7ec9b2cd01ae', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('4f187629-96c5-4696-9817-e23d18019241', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('4f187629-96c5-4696-9817-e23d18019241', '${rolesScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('4f187629-96c5-4696-9817-e23d18019241', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('8f3eca4b-2621-407b-8499-4e00b57caae8', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('8f3eca4b-2621-407b-8499-4e00b57caae8', '', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('8f3eca4b-2621-407b-8499-4e00b57caae8', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('6747b15d-6950-4e9e-992a-fce71215ad12', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('6747b15d-6950-4e9e-992a-fce71215ad12', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('a0093c54-0826-4666-9557-3233e6be7ff7', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('a0093c54-0826-4666-9557-3233e6be7ff7', '${offlineAccessScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('1bc050b5-b982-4107-8b55-3500654c5426', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('1bc050b5-b982-4107-8b55-3500654c5426', '${samlRoleListScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('ff25c7ed-164d-4556-85d9-193193c025ca', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('ff25c7ed-164d-4556-85d9-193193c025ca', '${profileScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('ff25c7ed-164d-4556-85d9-193193c025ca', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('85f5d4de-1159-4385-b47a-2624724fb2cf', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('85f5d4de-1159-4385-b47a-2624724fb2cf', '${emailScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('85f5d4de-1159-4385-b47a-2624724fb2cf', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('72f04a91-426c-4691-bddb-58ced7f53b0a', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('72f04a91-426c-4691-bddb-58ced7f53b0a', '${addressScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('72f04a91-426c-4691-bddb-58ced7f53b0a', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('614d16e8-4c8f-4a48-a1d1-91d0bf237195', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('614d16e8-4c8f-4a48-a1d1-91d0bf237195', '${phoneScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('614d16e8-4c8f-4a48-a1d1-91d0bf237195', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('fd7a4932-739c-46c2-93d3-c43e3d3b4a22', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('fd7a4932-739c-46c2-93d3-c43e3d3b4a22', '${rolesScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('fd7a4932-739c-46c2-93d3-c43e3d3b4a22', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('5469a308-5768-474c-9ab6-39e98a21b841', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('5469a308-5768-474c-9ab6-39e98a21b841', '', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('5469a308-5768-474c-9ab6-39e98a21b841', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('11938e7f-466f-4e38-8e1b-dcd01f70a0fd', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('11938e7f-466f-4e38-8e1b-dcd01f70a0fd', 'true', 'include.in.token.scope');


--
-- TOC entry 4155 (class 0 OID 16464)
-- Dependencies: 229
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('740d7d62-c828-439b-a4c0-6f513354894a', '86ff35aa-e6a2-4eae-85e6-cbe8861a9c2e', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('0fc80003-6ce5-46c2-a047-1d0e44291402', '86ff35aa-e6a2-4eae-85e6-cbe8861a9c2e', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('ea668f5b-d4e0-415e-962b-a241c6374ecf', '86ff35aa-e6a2-4eae-85e6-cbe8861a9c2e', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('9fd6733e-200a-4f4a-bcbc-aad28d5a919a', '86ff35aa-e6a2-4eae-85e6-cbe8861a9c2e', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('666fea7e-1491-48d3-83ac-229faaaa9aa6', '86ff35aa-e6a2-4eae-85e6-cbe8861a9c2e', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('21967484-d12e-48b0-8a2d-acc885559c01', '86ff35aa-e6a2-4eae-85e6-cbe8861a9c2e', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('740d7d62-c828-439b-a4c0-6f513354894a', 'f141d59d-1c7a-49d8-a3ce-566db1a2d612', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('740d7d62-c828-439b-a4c0-6f513354894a', '8f3eca4b-2621-407b-8499-4e00b57caae8', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('740d7d62-c828-439b-a4c0-6f513354894a', '4f187629-96c5-4696-9817-e23d18019241', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('740d7d62-c828-439b-a4c0-6f513354894a', '50d34770-cf89-4dd0-90c3-81f216bcb84f', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('740d7d62-c828-439b-a4c0-6f513354894a', '3d130846-07fd-49e3-8977-58ce8f3db9ca', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('740d7d62-c828-439b-a4c0-6f513354894a', '2fd3e2bf-b67f-498d-97f9-7ec9b2cd01ae', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('740d7d62-c828-439b-a4c0-6f513354894a', '6747b15d-6950-4e9e-992a-fce71215ad12', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('740d7d62-c828-439b-a4c0-6f513354894a', 'f49b1a89-50cf-49d5-a83a-f0114459f367', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('0fc80003-6ce5-46c2-a047-1d0e44291402', 'f141d59d-1c7a-49d8-a3ce-566db1a2d612', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('0fc80003-6ce5-46c2-a047-1d0e44291402', '8f3eca4b-2621-407b-8499-4e00b57caae8', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('0fc80003-6ce5-46c2-a047-1d0e44291402', '4f187629-96c5-4696-9817-e23d18019241', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('0fc80003-6ce5-46c2-a047-1d0e44291402', '50d34770-cf89-4dd0-90c3-81f216bcb84f', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('0fc80003-6ce5-46c2-a047-1d0e44291402', '3d130846-07fd-49e3-8977-58ce8f3db9ca', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('0fc80003-6ce5-46c2-a047-1d0e44291402', '2fd3e2bf-b67f-498d-97f9-7ec9b2cd01ae', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('0fc80003-6ce5-46c2-a047-1d0e44291402', '6747b15d-6950-4e9e-992a-fce71215ad12', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('0fc80003-6ce5-46c2-a047-1d0e44291402', 'f49b1a89-50cf-49d5-a83a-f0114459f367', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('ea668f5b-d4e0-415e-962b-a241c6374ecf', 'f141d59d-1c7a-49d8-a3ce-566db1a2d612', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('ea668f5b-d4e0-415e-962b-a241c6374ecf', '8f3eca4b-2621-407b-8499-4e00b57caae8', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('ea668f5b-d4e0-415e-962b-a241c6374ecf', '4f187629-96c5-4696-9817-e23d18019241', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('ea668f5b-d4e0-415e-962b-a241c6374ecf', '50d34770-cf89-4dd0-90c3-81f216bcb84f', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('ea668f5b-d4e0-415e-962b-a241c6374ecf', '3d130846-07fd-49e3-8977-58ce8f3db9ca', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('ea668f5b-d4e0-415e-962b-a241c6374ecf', '2fd3e2bf-b67f-498d-97f9-7ec9b2cd01ae', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('ea668f5b-d4e0-415e-962b-a241c6374ecf', '6747b15d-6950-4e9e-992a-fce71215ad12', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('ea668f5b-d4e0-415e-962b-a241c6374ecf', 'f49b1a89-50cf-49d5-a83a-f0114459f367', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('9fd6733e-200a-4f4a-bcbc-aad28d5a919a', 'f141d59d-1c7a-49d8-a3ce-566db1a2d612', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('9fd6733e-200a-4f4a-bcbc-aad28d5a919a', '8f3eca4b-2621-407b-8499-4e00b57caae8', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('9fd6733e-200a-4f4a-bcbc-aad28d5a919a', '4f187629-96c5-4696-9817-e23d18019241', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('9fd6733e-200a-4f4a-bcbc-aad28d5a919a', '50d34770-cf89-4dd0-90c3-81f216bcb84f', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('9fd6733e-200a-4f4a-bcbc-aad28d5a919a', '3d130846-07fd-49e3-8977-58ce8f3db9ca', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('9fd6733e-200a-4f4a-bcbc-aad28d5a919a', '2fd3e2bf-b67f-498d-97f9-7ec9b2cd01ae', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('9fd6733e-200a-4f4a-bcbc-aad28d5a919a', '6747b15d-6950-4e9e-992a-fce71215ad12', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('9fd6733e-200a-4f4a-bcbc-aad28d5a919a', 'f49b1a89-50cf-49d5-a83a-f0114459f367', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('666fea7e-1491-48d3-83ac-229faaaa9aa6', 'f141d59d-1c7a-49d8-a3ce-566db1a2d612', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('666fea7e-1491-48d3-83ac-229faaaa9aa6', '8f3eca4b-2621-407b-8499-4e00b57caae8', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('666fea7e-1491-48d3-83ac-229faaaa9aa6', '4f187629-96c5-4696-9817-e23d18019241', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('666fea7e-1491-48d3-83ac-229faaaa9aa6', '50d34770-cf89-4dd0-90c3-81f216bcb84f', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('666fea7e-1491-48d3-83ac-229faaaa9aa6', '3d130846-07fd-49e3-8977-58ce8f3db9ca', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('666fea7e-1491-48d3-83ac-229faaaa9aa6', '2fd3e2bf-b67f-498d-97f9-7ec9b2cd01ae', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('666fea7e-1491-48d3-83ac-229faaaa9aa6', '6747b15d-6950-4e9e-992a-fce71215ad12', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('666fea7e-1491-48d3-83ac-229faaaa9aa6', 'f49b1a89-50cf-49d5-a83a-f0114459f367', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('21967484-d12e-48b0-8a2d-acc885559c01', 'f141d59d-1c7a-49d8-a3ce-566db1a2d612', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('21967484-d12e-48b0-8a2d-acc885559c01', '8f3eca4b-2621-407b-8499-4e00b57caae8', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('21967484-d12e-48b0-8a2d-acc885559c01', '4f187629-96c5-4696-9817-e23d18019241', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('21967484-d12e-48b0-8a2d-acc885559c01', '50d34770-cf89-4dd0-90c3-81f216bcb84f', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('21967484-d12e-48b0-8a2d-acc885559c01', '3d130846-07fd-49e3-8977-58ce8f3db9ca', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('21967484-d12e-48b0-8a2d-acc885559c01', '2fd3e2bf-b67f-498d-97f9-7ec9b2cd01ae', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('21967484-d12e-48b0-8a2d-acc885559c01', '6747b15d-6950-4e9e-992a-fce71215ad12', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('21967484-d12e-48b0-8a2d-acc885559c01', 'f49b1a89-50cf-49d5-a83a-f0114459f367', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', '86ff35aa-e6a2-4eae-85e6-cbe8861a9c2e', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', 'f141d59d-1c7a-49d8-a3ce-566db1a2d612', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', '8f3eca4b-2621-407b-8499-4e00b57caae8', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', '4f187629-96c5-4696-9817-e23d18019241', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', '50d34770-cf89-4dd0-90c3-81f216bcb84f', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', '3d130846-07fd-49e3-8977-58ce8f3db9ca', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', '2fd3e2bf-b67f-498d-97f9-7ec9b2cd01ae', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', '6747b15d-6950-4e9e-992a-fce71215ad12', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', 'f49b1a89-50cf-49d5-a83a-f0114459f367', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('f7af93f2-37c5-4cf6-b07e-7b6620cf8458', '1bc050b5-b982-4107-8b55-3500654c5426', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('09e07cd8-2e94-4ce2-acbe-981d5d672371', '1bc050b5-b982-4107-8b55-3500654c5426', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('e301c57c-ca49-452f-a76d-f9f959656d48', '1bc050b5-b982-4107-8b55-3500654c5426', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('5d0fab1b-4e20-4c5a-b1bd-017bedd9e3e4', '1bc050b5-b982-4107-8b55-3500654c5426', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('8271513b-5e8c-4b3b-9374-5c477d2010a0', '1bc050b5-b982-4107-8b55-3500654c5426', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('78e8963c-3ea0-4eee-b438-237191ebab68', '1bc050b5-b982-4107-8b55-3500654c5426', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('f7af93f2-37c5-4cf6-b07e-7b6620cf8458', 'fd7a4932-739c-46c2-93d3-c43e3d3b4a22', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('f7af93f2-37c5-4cf6-b07e-7b6620cf8458', '85f5d4de-1159-4385-b47a-2624724fb2cf', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('f7af93f2-37c5-4cf6-b07e-7b6620cf8458', 'ff25c7ed-164d-4556-85d9-193193c025ca', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('f7af93f2-37c5-4cf6-b07e-7b6620cf8458', '5469a308-5768-474c-9ab6-39e98a21b841', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('f7af93f2-37c5-4cf6-b07e-7b6620cf8458', '614d16e8-4c8f-4a48-a1d1-91d0bf237195', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('f7af93f2-37c5-4cf6-b07e-7b6620cf8458', '11938e7f-466f-4e38-8e1b-dcd01f70a0fd', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('f7af93f2-37c5-4cf6-b07e-7b6620cf8458', 'a0093c54-0826-4666-9557-3233e6be7ff7', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('f7af93f2-37c5-4cf6-b07e-7b6620cf8458', '72f04a91-426c-4691-bddb-58ced7f53b0a', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('09e07cd8-2e94-4ce2-acbe-981d5d672371', 'fd7a4932-739c-46c2-93d3-c43e3d3b4a22', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('09e07cd8-2e94-4ce2-acbe-981d5d672371', '85f5d4de-1159-4385-b47a-2624724fb2cf', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('09e07cd8-2e94-4ce2-acbe-981d5d672371', 'ff25c7ed-164d-4556-85d9-193193c025ca', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('09e07cd8-2e94-4ce2-acbe-981d5d672371', '5469a308-5768-474c-9ab6-39e98a21b841', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('09e07cd8-2e94-4ce2-acbe-981d5d672371', '614d16e8-4c8f-4a48-a1d1-91d0bf237195', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('09e07cd8-2e94-4ce2-acbe-981d5d672371', '11938e7f-466f-4e38-8e1b-dcd01f70a0fd', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('09e07cd8-2e94-4ce2-acbe-981d5d672371', 'a0093c54-0826-4666-9557-3233e6be7ff7', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('09e07cd8-2e94-4ce2-acbe-981d5d672371', '72f04a91-426c-4691-bddb-58ced7f53b0a', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('e301c57c-ca49-452f-a76d-f9f959656d48', 'fd7a4932-739c-46c2-93d3-c43e3d3b4a22', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('e301c57c-ca49-452f-a76d-f9f959656d48', '85f5d4de-1159-4385-b47a-2624724fb2cf', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('e301c57c-ca49-452f-a76d-f9f959656d48', 'ff25c7ed-164d-4556-85d9-193193c025ca', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('e301c57c-ca49-452f-a76d-f9f959656d48', '5469a308-5768-474c-9ab6-39e98a21b841', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('e301c57c-ca49-452f-a76d-f9f959656d48', '614d16e8-4c8f-4a48-a1d1-91d0bf237195', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('e301c57c-ca49-452f-a76d-f9f959656d48', '11938e7f-466f-4e38-8e1b-dcd01f70a0fd', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('e301c57c-ca49-452f-a76d-f9f959656d48', 'a0093c54-0826-4666-9557-3233e6be7ff7', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('e301c57c-ca49-452f-a76d-f9f959656d48', '72f04a91-426c-4691-bddb-58ced7f53b0a', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('5d0fab1b-4e20-4c5a-b1bd-017bedd9e3e4', 'fd7a4932-739c-46c2-93d3-c43e3d3b4a22', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('5d0fab1b-4e20-4c5a-b1bd-017bedd9e3e4', '85f5d4de-1159-4385-b47a-2624724fb2cf', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('5d0fab1b-4e20-4c5a-b1bd-017bedd9e3e4', 'ff25c7ed-164d-4556-85d9-193193c025ca', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('5d0fab1b-4e20-4c5a-b1bd-017bedd9e3e4', '5469a308-5768-474c-9ab6-39e98a21b841', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('5d0fab1b-4e20-4c5a-b1bd-017bedd9e3e4', '614d16e8-4c8f-4a48-a1d1-91d0bf237195', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('5d0fab1b-4e20-4c5a-b1bd-017bedd9e3e4', '11938e7f-466f-4e38-8e1b-dcd01f70a0fd', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('5d0fab1b-4e20-4c5a-b1bd-017bedd9e3e4', 'a0093c54-0826-4666-9557-3233e6be7ff7', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('5d0fab1b-4e20-4c5a-b1bd-017bedd9e3e4', '72f04a91-426c-4691-bddb-58ced7f53b0a', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('8271513b-5e8c-4b3b-9374-5c477d2010a0', 'fd7a4932-739c-46c2-93d3-c43e3d3b4a22', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('8271513b-5e8c-4b3b-9374-5c477d2010a0', '85f5d4de-1159-4385-b47a-2624724fb2cf', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('8271513b-5e8c-4b3b-9374-5c477d2010a0', 'ff25c7ed-164d-4556-85d9-193193c025ca', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('8271513b-5e8c-4b3b-9374-5c477d2010a0', '5469a308-5768-474c-9ab6-39e98a21b841', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('8271513b-5e8c-4b3b-9374-5c477d2010a0', '614d16e8-4c8f-4a48-a1d1-91d0bf237195', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('8271513b-5e8c-4b3b-9374-5c477d2010a0', '11938e7f-466f-4e38-8e1b-dcd01f70a0fd', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('8271513b-5e8c-4b3b-9374-5c477d2010a0', 'a0093c54-0826-4666-9557-3233e6be7ff7', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('8271513b-5e8c-4b3b-9374-5c477d2010a0', '72f04a91-426c-4691-bddb-58ced7f53b0a', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('78e8963c-3ea0-4eee-b438-237191ebab68', 'fd7a4932-739c-46c2-93d3-c43e3d3b4a22', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('78e8963c-3ea0-4eee-b438-237191ebab68', '85f5d4de-1159-4385-b47a-2624724fb2cf', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('78e8963c-3ea0-4eee-b438-237191ebab68', 'ff25c7ed-164d-4556-85d9-193193c025ca', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('78e8963c-3ea0-4eee-b438-237191ebab68', '5469a308-5768-474c-9ab6-39e98a21b841', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('78e8963c-3ea0-4eee-b438-237191ebab68', '614d16e8-4c8f-4a48-a1d1-91d0bf237195', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('78e8963c-3ea0-4eee-b438-237191ebab68', '11938e7f-466f-4e38-8e1b-dcd01f70a0fd', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('78e8963c-3ea0-4eee-b438-237191ebab68', 'a0093c54-0826-4666-9557-3233e6be7ff7', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('78e8963c-3ea0-4eee-b438-237191ebab68', '72f04a91-426c-4691-bddb-58ced7f53b0a', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('8f553005-b544-4e27-8fbc-a9a517ed6fe9', '1bc050b5-b982-4107-8b55-3500654c5426', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('8f553005-b544-4e27-8fbc-a9a517ed6fe9', 'fd7a4932-739c-46c2-93d3-c43e3d3b4a22', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('8f553005-b544-4e27-8fbc-a9a517ed6fe9', '85f5d4de-1159-4385-b47a-2624724fb2cf', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('8f553005-b544-4e27-8fbc-a9a517ed6fe9', 'ff25c7ed-164d-4556-85d9-193193c025ca', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('8f553005-b544-4e27-8fbc-a9a517ed6fe9', '5469a308-5768-474c-9ab6-39e98a21b841', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('8f553005-b544-4e27-8fbc-a9a517ed6fe9', '614d16e8-4c8f-4a48-a1d1-91d0bf237195', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('8f553005-b544-4e27-8fbc-a9a517ed6fe9', '11938e7f-466f-4e38-8e1b-dcd01f70a0fd', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('8f553005-b544-4e27-8fbc-a9a517ed6fe9', 'a0093c54-0826-4666-9557-3233e6be7ff7', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('8f553005-b544-4e27-8fbc-a9a517ed6fe9', '72f04a91-426c-4691-bddb-58ced7f53b0a', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', '1bc050b5-b982-4107-8b55-3500654c5426', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', 'fd7a4932-739c-46c2-93d3-c43e3d3b4a22', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', '85f5d4de-1159-4385-b47a-2624724fb2cf', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', 'ff25c7ed-164d-4556-85d9-193193c025ca', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', '5469a308-5768-474c-9ab6-39e98a21b841', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', '614d16e8-4c8f-4a48-a1d1-91d0bf237195', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', '11938e7f-466f-4e38-8e1b-dcd01f70a0fd', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', 'a0093c54-0826-4666-9557-3233e6be7ff7', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', '72f04a91-426c-4691-bddb-58ced7f53b0a', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('df77c1aa-6543-489f-919a-3880f58d5494', '1bc050b5-b982-4107-8b55-3500654c5426', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('df77c1aa-6543-489f-919a-3880f58d5494', 'fd7a4932-739c-46c2-93d3-c43e3d3b4a22', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('df77c1aa-6543-489f-919a-3880f58d5494', '85f5d4de-1159-4385-b47a-2624724fb2cf', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('df77c1aa-6543-489f-919a-3880f58d5494', 'ff25c7ed-164d-4556-85d9-193193c025ca', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('df77c1aa-6543-489f-919a-3880f58d5494', '5469a308-5768-474c-9ab6-39e98a21b841', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('df77c1aa-6543-489f-919a-3880f58d5494', '614d16e8-4c8f-4a48-a1d1-91d0bf237195', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('df77c1aa-6543-489f-919a-3880f58d5494', '11938e7f-466f-4e38-8e1b-dcd01f70a0fd', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('df77c1aa-6543-489f-919a-3880f58d5494', 'a0093c54-0826-4666-9557-3233e6be7ff7', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('df77c1aa-6543-489f-919a-3880f58d5494', '72f04a91-426c-4691-bddb-58ced7f53b0a', false);


--
-- TOC entry 4156 (class 0 OID 16468)
-- Dependencies: 230
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.client_scope_role_mapping (scope_id, role_id) VALUES ('f49b1a89-50cf-49d5-a83a-f0114459f367', 'bc77550a-7271-4beb-a829-4cec806b23a6');
INSERT INTO public.client_scope_role_mapping (scope_id, role_id) VALUES ('a0093c54-0826-4666-9557-3233e6be7ff7', 'b9688af1-84bc-4bbf-892d-5732be692351');


--
-- TOC entry 4157 (class 0 OID 16471)
-- Dependencies: 231
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4158 (class 0 OID 16476)
-- Dependencies: 232
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4159 (class 0 OID 16479)
-- Dependencies: 233
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4160 (class 0 OID 16484)
-- Dependencies: 234
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4161 (class 0 OID 16487)
-- Dependencies: 235
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4162 (class 0 OID 16490)
-- Dependencies: 236
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4163 (class 0 OID 16495)
-- Dependencies: 237
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('8f4337a4-cc91-4269-8ec3-afecd226d5f4', 'Trusted Hosts', 'master', 'trusted-hosts', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('fb5c5f6e-a747-47e0-b1c8-ca64d87f9145', 'Consent Required', 'master', 'consent-required', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('5e97c429-114b-4f3c-93d5-992443e3a005', 'Full Scope Disabled', 'master', 'scope', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('43b3186c-0398-41ad-a198-e95198bcd129', 'Max Clients Limit', 'master', 'max-clients', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('efd39b34-edd4-4b3a-90f9-0a9645458c05', 'Allowed Protocol Mapper Types', 'master', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('ca369719-2e0d-45a5-9452-08148b591ab8', 'Allowed Client Scopes', 'master', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('c60353e4-5d6e-4f7f-bf10-eb310006ba8e', 'Allowed Protocol Mapper Types', 'master', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'authenticated');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('28490a4b-3709-47d6-8152-a21b22f99c34', 'Allowed Client Scopes', 'master', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'authenticated');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('1ec00a18-4d5a-466f-b3e2-0e1a1a99085c', 'fallback-HS256', 'master', 'hmac-generated', 'org.keycloak.keys.KeyProvider', 'master', NULL);
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('b4581e0d-dec2-40b7-8917-c608b2d8251a', 'fallback-RS256', 'master', 'rsa-generated', 'org.keycloak.keys.KeyProvider', 'master', NULL);
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('a8a59008-0718-4104-94ef-509086e1586a', 'rsa-generated', 'clin', 'rsa-generated', 'org.keycloak.keys.KeyProvider', 'clin', NULL);
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('a39da6d8-f61d-4a83-8406-a6973c00df62', 'hmac-generated', 'clin', 'hmac-generated', 'org.keycloak.keys.KeyProvider', 'clin', NULL);
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('2a3561a8-ac07-45a8-969c-ec58b7de74d9', 'aes-generated', 'clin', 'aes-generated', 'org.keycloak.keys.KeyProvider', 'clin', NULL);
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('419ddca4-b61b-4f54-b4ef-1555bab3603c', 'Trusted Hosts', 'clin', 'trusted-hosts', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'clin', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('42766582-02bd-4cef-a8c9-66c10c2ea7d3', 'Consent Required', 'clin', 'consent-required', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'clin', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('4b96dd64-9295-4703-879d-3398bebf1b86', 'Full Scope Disabled', 'clin', 'scope', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'clin', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('280b145c-0593-4967-9382-68d0098942cc', 'Max Clients Limit', 'clin', 'max-clients', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'clin', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('57626f43-2eb3-4388-9ed0-965a842a5d49', 'Allowed Protocol Mapper Types', 'clin', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'clin', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('f6d78e70-9fed-43e4-84b3-75fb2a9b630c', 'Allowed Client Scopes', 'clin', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'clin', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('b1767f68-f325-4903-b6c7-1b972b473823', 'Allowed Protocol Mapper Types', 'clin', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'clin', 'authenticated');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('1e856df2-0d00-44f6-b7fd-8408d99d2901', 'Allowed Client Scopes', 'clin', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'clin', 'authenticated');


--
-- TOC entry 4164 (class 0 OID 16500)
-- Dependencies: 238
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.component_config (id, component_id, name, value) VALUES ('3d2abd17-43b5-4776-88e8-97893570acd1', 'ca369719-2e0d-45a5-9452-08148b591ab8', 'allow-default-scopes', 'true');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('22a13d4c-c465-4bd8-b0c3-21b7ed457048', '43b3186c-0398-41ad-a198-e95198bcd129', 'max-clients', '200');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('b132a1c6-dde1-41d6-8e16-7e6c947d9bb0', '8f4337a4-cc91-4269-8ec3-afecd226d5f4', 'host-sending-registration-request-must-match', 'true');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('b69d45d5-8b04-4d91-a746-5cd01c1fc035', '8f4337a4-cc91-4269-8ec3-afecd226d5f4', 'client-uris-must-match', 'true');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('637b8548-4e1a-4d36-8885-8338688ccba1', '28490a4b-3709-47d6-8152-a21b22f99c34', 'allow-default-scopes', 'true');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('6a1e32cc-ece1-4194-b0b5-ce46a82bbf98', 'efd39b34-edd4-4b3a-90f9-0a9645458c05', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('aa101ccc-dddc-49b7-aadf-435ccfba132a', 'efd39b34-edd4-4b3a-90f9-0a9645458c05', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('9d5c8bf4-83c9-44c2-b139-e68713d55678', 'efd39b34-edd4-4b3a-90f9-0a9645458c05', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('c7e6a14a-4eaf-4d65-b5ee-d218b0c028e9', 'efd39b34-edd4-4b3a-90f9-0a9645458c05', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('afb93f72-0e62-47de-ba07-db7896d3c00c', 'efd39b34-edd4-4b3a-90f9-0a9645458c05', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('f5898362-abab-46ea-ab0e-6c816fa0bdf1', 'efd39b34-edd4-4b3a-90f9-0a9645458c05', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('ddfb4447-2f40-4967-b430-fc1a8b7adb76', 'efd39b34-edd4-4b3a-90f9-0a9645458c05', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('245586a9-c3c8-48a0-a93b-943c60666c6c', 'efd39b34-edd4-4b3a-90f9-0a9645458c05', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('fa85a3ed-9e00-4bae-9cdd-1d0e4a3aaeca', 'c60353e4-5d6e-4f7f-bf10-eb310006ba8e', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('340d55b0-42a7-4b58-8948-2321e5fb1683', 'c60353e4-5d6e-4f7f-bf10-eb310006ba8e', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('1e2b57d3-b25b-480d-8976-a27b3c52d707', 'c60353e4-5d6e-4f7f-bf10-eb310006ba8e', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('b78ff163-c1f2-4124-919a-44705a290375', 'c60353e4-5d6e-4f7f-bf10-eb310006ba8e', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('1b0a919a-7ce9-4b87-b189-d50da0f29b4c', 'c60353e4-5d6e-4f7f-bf10-eb310006ba8e', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('358a66ae-8dda-44be-a234-8d937ab5a8f7', 'c60353e4-5d6e-4f7f-bf10-eb310006ba8e', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('b3713802-6926-43aa-ab36-6eb402db7e6f', 'c60353e4-5d6e-4f7f-bf10-eb310006ba8e', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('6634801f-5efe-49de-a27d-714534c418df', 'c60353e4-5d6e-4f7f-bf10-eb310006ba8e', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('10e3c49a-5e67-4e61-9a96-eabe1ca7fac7', '1ec00a18-4d5a-466f-b3e2-0e1a1a99085c', 'kid', 'c0271839-10f1-46a0-a687-ed620cf10709');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('c13740dc-b434-4346-97d1-c074c6e1c578', '1ec00a18-4d5a-466f-b3e2-0e1a1a99085c', 'secret', 'a4tl4L6fMRj3Ow4BgbITVqDfkNZl2nnERdqaVyv8WgvGCHfi0xmaVvanTP0EXdxrBLSzPqhc6aGbcamhHBjAIA');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('1dab78d2-2331-4fc1-969b-43efb7a2a650', '1ec00a18-4d5a-466f-b3e2-0e1a1a99085c', 'algorithm', 'HS256');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('bb1bda21-c4d3-4219-a73b-9bb30a8af8a9', '1ec00a18-4d5a-466f-b3e2-0e1a1a99085c', 'priority', '-100');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('6025a456-1928-4fab-a4e6-7b877819b8d4', 'b4581e0d-dec2-40b7-8917-c608b2d8251a', 'privateKey', 'MIIEogIBAAKCAQEAm8YOcgsNKzhFcztKawK9bk6gYkKVetCCMXQeMvZCVXy2sd/uN+pZcBrGzaPJoaPFmnnz+uIhFwVoHajDnMrBwhhVsYxMLt1zn5V6GPeDsyTRf45QM9QGYeWQXApHWD+t7B9lFIJo47SxkQmjc4IRiPZtTVXZerrWod2ywr5GYASJmFP3lc4fmZvnlOq967ET1r3ZN5W3AToudIIodalZc+FE+b0jISCbD/fZmt/Iau/JPO0f1RroZBe4B9qRaZ8HbcrphFwDmBVs89S0RiXz//KI4QkcAPaw0nus5hEelfp9w2itfspNx6T6sWt7+1E9/uQ2PMXTTHlK3M3cBOY5uwIDAQABAoIBAF1Y5YUv3DdfJDc2e5T+8les5G2dqwgK9Un/ZK1zZzLlZnHXWGDHncsRMLtAgG7NvnegxzU710p9YfQMExTdaBkRDiE0it62tDgYki9t+80ZrjV7KdK1JxH5SHXvbuuSVX4fHiqZL5Psz0+z7/AjLLDfw4ZJgOcMGdysBxiuf2u/u6iun9fJHUJB1tAz1fTcbRWHqL2NB8+NE4PiCITekPJgTIQrHlNmy4EeUf5g1Sf/ojGghV/yIVVOBXLqUUrNkuiaHAkFXsr4nHbXx0TY5tllzkzV1TsGvAuKFSr72OpCA3/ErvuS2MGJgh9X76ebWouyTt15RASprIrIQHQnDLkCgYEA3g+/pYlLGxZEHdfEit21LfIy0Uju6z+/FP3Q/RiH2eMKnz6QuHO97W8+KF/QQPey9Yzht6pOkCOqYkraI2dKk29BwAln7ezpNU/GwKsnd4zNZykhnTM7z2E6OqugBDJEijotFr3XuaaN6EU3mpWcYL3os8ZBmFuDPHr2jDKFQoUCgYEAs5TEXwtGB88ZmEbDU4Fsc+45hbEXszW+vcFo5X4ve0vqw5vZHSmozE3ox/FqhFk0Rf5xsDF58wyuXw9j4yHapppBZwvh7pGQxmYiSdqS/EZsjnzq8XOSvvU4p5ninCOWyBQt6izqBjTg5IOXLtH3Gp/7z/S7nU/fRCnDlC9V3z8CgYA7Yk7H//070yqIKImA8WVgUiLQ4QYzlyqMfIwFAyhhVlwi1eJx0VH7SwJ+XZEdrqAHFpPOQBceaMtJ2eaYDSleYCRfLKTEddSv0xO9toepatgLPG6m0WqvPLsLsZXrSV4W8RPZvw8PsMDGWqxSBKx7Go4+dUhZbC+eXuvL9j642QKBgHFE/4uXd8eLKHC1CZTNSJPjCeM6rWE7ICFeMgS2z8osO1rAHXTYhwC+j3o12uK5xU/0ys7AllPohr+s3GsyOlDlcSVHCG3K4Q9S8oO02wtGfEhvoF1FcaUC1YZZeObVR9DRcZiIVeAuUD+yhJRimULw8AreKcxyybebxCHerYJPAoGAEIq6zBxlFJhZOeGprewqSpnsHh/k8QJ55WcErICjTZpjM4LPErcnZ3Cc01OLxOTNKj+tWX5tdaK6ix0eqBHLnLntXQ8rlQTlNG/xCkG94uLRF8jkjjS93mzq/sGvOzKn6UDtuoKXry64VXJVSNgHW89O4qvxSO45Il/1C8355+M=');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('d5b75e74-83dd-4308-8ade-12123107dd82', 'b4581e0d-dec2-40b7-8917-c608b2d8251a', 'priority', '-100');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('5209b64d-4859-4b3d-ba78-76a0eae1cf2d', 'b4581e0d-dec2-40b7-8917-c608b2d8251a', 'certificate', 'MIICmzCCAYMCBgGH4i37QjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjMwNTAzMTUxMjU2WhcNMzMwNTAzMTUxNDM2WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCbxg5yCw0rOEVzO0prAr1uTqBiQpV60IIxdB4y9kJVfLax3+436llwGsbNo8mho8WaefP64iEXBWgdqMOcysHCGFWxjEwu3XOflXoY94OzJNF/jlAz1AZh5ZBcCkdYP63sH2UUgmjjtLGRCaNzghGI9m1NVdl6utah3bLCvkZgBImYU/eVzh+Zm+eU6r3rsRPWvdk3lbcBOi50gih1qVlz4UT5vSMhIJsP99ma38hq78k87R/VGuhkF7gH2pFpnwdtyumEXAOYFWzz1LRGJfP/8ojhCRwA9rDSe6zmER6V+n3DaK1+yk3HpPqxa3v7UT3+5DY8xdNMeUrczdwE5jm7AgMBAAEwDQYJKoZIhvcNAQELBQADggEBAAHEkdjWcmVBeYw3NWRurqIFO4pKwZsXyYCMgRAWpNmTw/7rH7v4WHeUpOppk5gjJIbuCq6tduzmn6aRr3NZ9NqSvAzRnt8wxPt0I0aICR1Oqe0NGCS3wFSrQCZn8jYyGGwvQFXLJKLSduFTkB+KVGHpIcBqWEZieFYW6QbQUnWk5sz88wTu/eI7rgCojZNNhSlz/c+oX8QG4NvVlYxbRqSO+mUhqlqoGBu0vQcRUQ1tHIYQJIemctqKSwPAbOYiGH0FsCIBFfn2fJx6uI+68HYntXKB4IDKBtg1V3dUYSrHu4nCk4Ad1s0IA1CSrulnRuw9DIOFk44bg7Tl6DuP/5g=');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('8fcaea5e-338e-4ba4-9459-ff3c1342f69d', 'b4581e0d-dec2-40b7-8917-c608b2d8251a', 'algorithm', 'RS256');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('87896043-e2cb-412b-9670-1caf71f79cf3', '2a3561a8-ac07-45a8-969c-ec58b7de74d9', 'secret', 'f3nEIDoTNjgAEm1Q1YD_oQ');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('e2b13caf-803a-4259-841a-cc8c170cc24a', '2a3561a8-ac07-45a8-969c-ec58b7de74d9', 'kid', '40f7f4b6-bca3-4a3c-a490-17a3b585df5d');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('77b6f39b-24fb-4754-8db1-0124d4437a6b', '2a3561a8-ac07-45a8-969c-ec58b7de74d9', 'priority', '100');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('d834b614-accd-4cc1-9901-51de6677be45', 'a8a59008-0718-4104-94ef-509086e1586a', 'privateKey', 'MIIEowIBAAKCAQEAhYK2urCGj0pbDo4FbHv4R3gqRwa/uEBkV34y+zjrk8zZYAl5vpolXs8qjsATOD9JsxBrz0gxapnWlfxY6AXEAsLqxSkgrO69iOVOoqGBoCioNTGBdPI/qk7/tWR1Yxyxe0tU0JwfOclWxoPOuHcTpYv06NAsoJK4tgfE2kzZMeyfYsXmWJfGsprKM2wVm6caQybx/FMKZg/hhJlEtL282d/UWylrOucI/kvGVOiIeTLAlarwXlXL8yJT/rlLzRs0sqxbwx5tFvGZLZlKlLyYH7OoSqK6JVm5hCWahmsbe04A0UWAU3Jph1lvb0FlBneJdBIGnXf9HM+siw/CDkwwTQIDAQABAoIBAG8bD4wfWWunmk1rfTIBnOWFJ9HB2QyxcY+qMy0D+nAeWovkds9aolzbFHSFfbkiWefNc5qlXpJzAbQBs88q9SrDIPMAvfOMHmjtQ1puA1zQWOMjlrNG4hqN8Zj3yAS6HS0YzLVqJ0ZEupUrnX2/grcS2LZif7EFSPgbUQPGTj2Phew5KgEFzp5Cx9r8CO1yIUMXKTVpFpkCtPiu9cVzl6mhrDQnzph571gpXhDBgPxBVyZkuByMR+gVTP2Qb4Y5bRzrsx0T3fPEEUh4BhWxgLOQdzAlymdOMWNLJM5V9dUHdE2RtR8MTJIIYi7W3kU8dW3yIiw76scXVjiwYkElWqECgYEA+0AEFcZdczoAYvJYuz8FlJJdKNgy57oNtCYc4Vfj+23CeL3oiz4thCvMDM8pcy+/Vv/mg5aCUA/JuS4FdfrurO+KhTSbxgnMnT2y0w+CGjpUTnoWORjQ6MUYcn1pM21XQyMlQlQ+unDQbuTvuhOIEPSQU+A2HKOzqvZOhKog31UCgYEAiAjesMKE+rbLmEE7I4e/rVkkVrv547xcTzI0Pa2gQ6c5JrI4kWQy775wR95lsHMBGasKZPRg79SB/Fhyn2Rqvwks3lvlcKMGYmqQcHsddoHq5YjlkDga4ZvxfEYvGma4H3aRq+QvxC5JVUv74u2D6DhZbcP7tmk+VytYlcsi3RkCgYEAldBYHzvG4TxGmrlzG0O66hpUHlS8Fdyk6zSGp/+mW3fZK/HhRZXvwg3zf/fO+XYRG6k/JFuMnHythhPhAbZ8tvWmnUL/V5jkPyZZCO0IYOdC+gBmW+lmOEW+DBanshiSnd/JCcH+HWHDhzxPjZ6z1ZherwTUf0NFkL2JmCVxsHkCgYBEbNm+5YlIJwxPwHgDzjN++XjK2/C9ObDg8SrP33besM2RhlHn6BOq/gqyS86wq5hhFeS7lSTxXd4oVUEKpdL/1pioHGdTed0rQdj3iyXtxzmlTW/TVDVJSEx2q0LkL8jropNxd+0C7Blc+0RvB/Oyqi1phgwl29hMtnPvnOcjeQKBgE7EBdPqMs1VhAWLMZ30u8wbzx1uQ5FaMZbcOfuxyKpzlUZ7YlCGnwxTrUvl6Dp40R67FzrxLrDGcr9HtDCPZYQfs0YWQ6sAH2tvVjRtspedNF5PHjhVPRgXbLsA2OjrgSTxqfICTIuJbIZHayA9ghxG0F6jJmPWm4ffrju2/OnL');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('2fff65ea-c5ed-4826-a0c7-554ee47c41a1', 'a8a59008-0718-4104-94ef-509086e1586a', 'certificate', 'MIIClzCCAX8CBgGH4i5zFDANBgkqhkiG9w0BAQsFADAPMQ0wCwYDVQQDDARjbGluMB4XDTIzMDUwMzE1MTMyN1oXDTMzMDUwMzE1MTUwN1owDzENMAsGA1UEAwwEY2xpbjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAIWCtrqwho9KWw6OBWx7+Ed4KkcGv7hAZFd+Mvs465PM2WAJeb6aJV7PKo7AEzg/SbMQa89IMWqZ1pX8WOgFxALC6sUpIKzuvYjlTqKhgaAoqDUxgXTyP6pO/7VkdWMcsXtLVNCcHznJVsaDzrh3E6WL9OjQLKCSuLYHxNpM2THsn2LF5liXxrKayjNsFZunGkMm8fxTCmYP4YSZRLS9vNnf1FspazrnCP5LxlToiHkywJWq8F5Vy/MiU/65S80bNLKsW8MebRbxmS2ZSpS8mB+zqEqiuiVZuYQlmoZrG3tOANFFgFNyaYdZb29BZQZ3iXQSBp13/RzPrIsPwg5MME0CAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAaatA5ndEGp8eFNRablD0lxGDOvVp7gXRTwhj491yvcGJW2qfnbP/5Mmifo/HYlKqIlFF60VSfykUIEhthH1/Rlxoun9AthhtADgJoJih/iPUBdWKwXZh35PJMl3MEjPgN78sFn5ifJ9aIv5tmdJqvj9O6DizOUzHlSkGCk0NQaI3iDbC89jrK3asuTZyuwx8tDGCPvmWl1CZO57F+EwX+Qo3PSSLO2ynxTNPC9cgWQbShQXPLp8TYqN/ertf16voz81M19uffOzx5uhP2hfsDwdu3xzcCrKe861Gj2nJCb8/7fTIeWEZ3YOu+PCVvSXNvKWCyE22ZGdIdDLONosq3w==');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('b60f6222-b3fc-4f8c-b4ae-cd3bb3347051', 'a8a59008-0718-4104-94ef-509086e1586a', 'priority', '100');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('3d23014d-b8db-4c8e-9c73-2a5b93adb128', 'a39da6d8-f61d-4a83-8406-a6973c00df62', 'secret', 'TbHn-HZKLY4i5rIyUu8mU1cC4VewhuZzIdDcawSlGTaUIURCfen9QwW9PKNt8qGBT-ZMEgS--HIsAvOGzF60iA');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('a51e34df-d5d4-4762-b3a9-904c5b42e7fa', 'a39da6d8-f61d-4a83-8406-a6973c00df62', 'priority', '100');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('d6c4830d-23b7-4b48-b52a-9a65d55d373d', 'a39da6d8-f61d-4a83-8406-a6973c00df62', 'algorithm', 'HS256');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('4825e711-a0dc-448d-991f-b4ef369383a6', 'a39da6d8-f61d-4a83-8406-a6973c00df62', 'kid', '1c1732d2-83f1-4c1b-afff-0c0ec1501af8');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('615f8ff8-6649-4396-be2d-98725ed4a3fc', 'b1767f68-f325-4903-b6c7-1b972b473823', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('50fa6def-6d5e-4611-8105-52b5cf4cebbc', 'b1767f68-f325-4903-b6c7-1b972b473823', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('c132433d-34d2-4434-843d-45165fe39c31', 'b1767f68-f325-4903-b6c7-1b972b473823', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('9fe6c2cb-0994-4164-a8d5-b44c8cfa43ff', 'b1767f68-f325-4903-b6c7-1b972b473823', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('a82b46dd-1a00-4d94-806b-7999b149ade5', 'b1767f68-f325-4903-b6c7-1b972b473823', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('f6e236d1-f781-482b-b57b-8393b3f87147', 'b1767f68-f325-4903-b6c7-1b972b473823', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('d8cef726-4bcd-471e-aeea-735f47ed1236', 'b1767f68-f325-4903-b6c7-1b972b473823', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('91543356-b434-411e-b498-ea34f4c00ef3', 'b1767f68-f325-4903-b6c7-1b972b473823', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('27d361d6-6126-4441-80ee-5c229c2727f1', '280b145c-0593-4967-9382-68d0098942cc', 'max-clients', '200');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('fc373377-24f9-419b-a816-298aef71559b', '57626f43-2eb3-4388-9ed0-965a842a5d49', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('7cf0ecdd-8d68-4992-a489-efd9d7def7df', '57626f43-2eb3-4388-9ed0-965a842a5d49', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('e868145b-5743-46fe-88be-e883a62ea56e', '57626f43-2eb3-4388-9ed0-965a842a5d49', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('09ce7b64-9467-408d-8e78-9a37415993a1', '57626f43-2eb3-4388-9ed0-965a842a5d49', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('241ae057-53de-4bc1-a854-f621c3e43b11', '57626f43-2eb3-4388-9ed0-965a842a5d49', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('655cd6df-33d5-4d02-85d0-9caff1520096', '57626f43-2eb3-4388-9ed0-965a842a5d49', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('0570ae4d-9c73-49ee-97c4-506863bc3b79', '57626f43-2eb3-4388-9ed0-965a842a5d49', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('2894e97f-3859-4c26-aa67-5eba28737f6b', '57626f43-2eb3-4388-9ed0-965a842a5d49', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('8a7c5fe2-e0b5-4e96-9310-48f0cbdcff7f', 'f6d78e70-9fed-43e4-84b3-75fb2a9b630c', 'allow-default-scopes', 'true');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('f5fb2d73-3e78-470b-89a4-720e72402ede', '419ddca4-b61b-4f54-b4ef-1555bab3603c', 'host-sending-registration-request-must-match', 'true');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('cd5af8b8-53eb-4b5c-af47-2bc3ab9288cc', '419ddca4-b61b-4f54-b4ef-1555bab3603c', 'client-uris-must-match', 'true');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('6d19fcd8-ff5d-4ae7-b1aa-a025df4983e2', '1e856df2-0d00-44f6-b7fd-8408d99d2901', 'allow-default-scopes', 'true');


--
-- TOC entry 4165 (class 0 OID 16505)
-- Dependencies: 239
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.composite_role (composite, child_role) VALUES ('a55a6883-a186-4dad-aa5f-6ba0c9981ae4', '33a898bf-3cb2-463d-89b1-1ce2dff1c25f');
INSERT INTO public.composite_role (composite, child_role) VALUES ('a55a6883-a186-4dad-aa5f-6ba0c9981ae4', '5df22785-96e5-4e9d-8b78-b23dc7d79116');
INSERT INTO public.composite_role (composite, child_role) VALUES ('a55a6883-a186-4dad-aa5f-6ba0c9981ae4', '6cbfb24a-4d55-4d16-867b-c68ba9fded0c');
INSERT INTO public.composite_role (composite, child_role) VALUES ('a55a6883-a186-4dad-aa5f-6ba0c9981ae4', '4ef8f404-8cbb-40d0-aca9-c99e493b651b');
INSERT INTO public.composite_role (composite, child_role) VALUES ('a55a6883-a186-4dad-aa5f-6ba0c9981ae4', 'bfb9a7bd-b571-4ab2-a675-2175d9103892');
INSERT INTO public.composite_role (composite, child_role) VALUES ('a55a6883-a186-4dad-aa5f-6ba0c9981ae4', '80980eb3-b7c7-4796-a849-db4c47aed94e');
INSERT INTO public.composite_role (composite, child_role) VALUES ('a55a6883-a186-4dad-aa5f-6ba0c9981ae4', 'c20b8e05-e4fd-4b37-995a-a2bfdc637e51');
INSERT INTO public.composite_role (composite, child_role) VALUES ('a55a6883-a186-4dad-aa5f-6ba0c9981ae4', '3473fb60-b544-42d2-b6da-d9e00f81f0c2');
INSERT INTO public.composite_role (composite, child_role) VALUES ('a55a6883-a186-4dad-aa5f-6ba0c9981ae4', '8bdf4151-e2a8-4b7d-a154-779d00b39a8d');
INSERT INTO public.composite_role (composite, child_role) VALUES ('a55a6883-a186-4dad-aa5f-6ba0c9981ae4', 'c7ec562a-e1a1-475e-b9c0-a69b1e9949f1');
INSERT INTO public.composite_role (composite, child_role) VALUES ('a55a6883-a186-4dad-aa5f-6ba0c9981ae4', '273366be-ea57-4e4a-a4c8-b8d9c1061265');
INSERT INTO public.composite_role (composite, child_role) VALUES ('a55a6883-a186-4dad-aa5f-6ba0c9981ae4', 'efcb05dd-feee-4d94-bf59-1ff97e75e737');
INSERT INTO public.composite_role (composite, child_role) VALUES ('a55a6883-a186-4dad-aa5f-6ba0c9981ae4', 'f502d79f-c1be-4557-97c8-9da83a34d6bc');
INSERT INTO public.composite_role (composite, child_role) VALUES ('a55a6883-a186-4dad-aa5f-6ba0c9981ae4', '7c7feea0-e6a7-4efd-8174-9d27fd502405');
INSERT INTO public.composite_role (composite, child_role) VALUES ('a55a6883-a186-4dad-aa5f-6ba0c9981ae4', 'e0acdb97-9744-4560-8dc5-92031f1a678b');
INSERT INTO public.composite_role (composite, child_role) VALUES ('a55a6883-a186-4dad-aa5f-6ba0c9981ae4', 'dfc982d8-0579-4301-97ee-789b3054ec02');
INSERT INTO public.composite_role (composite, child_role) VALUES ('a55a6883-a186-4dad-aa5f-6ba0c9981ae4', '4582ffd3-3c4a-47ae-b457-9b0bfb112ccf');
INSERT INTO public.composite_role (composite, child_role) VALUES ('a55a6883-a186-4dad-aa5f-6ba0c9981ae4', '569cf9aa-9ea5-41fb-8729-d8abc74a1862');
INSERT INTO public.composite_role (composite, child_role) VALUES ('bfb9a7bd-b571-4ab2-a675-2175d9103892', 'dfc982d8-0579-4301-97ee-789b3054ec02');
INSERT INTO public.composite_role (composite, child_role) VALUES ('4ef8f404-8cbb-40d0-aca9-c99e493b651b', 'e0acdb97-9744-4560-8dc5-92031f1a678b');
INSERT INTO public.composite_role (composite, child_role) VALUES ('4ef8f404-8cbb-40d0-aca9-c99e493b651b', '569cf9aa-9ea5-41fb-8729-d8abc74a1862');
INSERT INTO public.composite_role (composite, child_role) VALUES ('d31a5d16-be94-4795-a857-8933093fb18e', '7e066a55-2291-424b-bb5f-8688a5200282');
INSERT INTO public.composite_role (composite, child_role) VALUES ('6d7cba7d-066e-4751-a078-43f3002100e4', '4e4a1af3-1a5c-41ba-8b64-edb01ddbc693');
INSERT INTO public.composite_role (composite, child_role) VALUES ('a55a6883-a186-4dad-aa5f-6ba0c9981ae4', 'eb3771a7-4553-4129-8d40-f5b2dbd1cb76');
INSERT INTO public.composite_role (composite, child_role) VALUES ('a55a6883-a186-4dad-aa5f-6ba0c9981ae4', '3699aa5e-e80f-48d6-b19e-0b6f213bd58e');
INSERT INTO public.composite_role (composite, child_role) VALUES ('a55a6883-a186-4dad-aa5f-6ba0c9981ae4', '06078de0-3785-479b-8764-a86bf4179794');
INSERT INTO public.composite_role (composite, child_role) VALUES ('a55a6883-a186-4dad-aa5f-6ba0c9981ae4', '7cff71ad-de17-4421-87b9-f09fa2e6b979');
INSERT INTO public.composite_role (composite, child_role) VALUES ('a55a6883-a186-4dad-aa5f-6ba0c9981ae4', 'a0bcc01d-16f2-4d00-89bf-1345f66ad378');
INSERT INTO public.composite_role (composite, child_role) VALUES ('a55a6883-a186-4dad-aa5f-6ba0c9981ae4', '470459bb-c1c5-4417-992c-97f66f430db8');
INSERT INTO public.composite_role (composite, child_role) VALUES ('a55a6883-a186-4dad-aa5f-6ba0c9981ae4', 'ce42bdc8-f028-4c05-a699-b129df771248');
INSERT INTO public.composite_role (composite, child_role) VALUES ('a55a6883-a186-4dad-aa5f-6ba0c9981ae4', 'f747c4ae-4c3f-4fdf-94d6-dbf934055a91');
INSERT INTO public.composite_role (composite, child_role) VALUES ('a55a6883-a186-4dad-aa5f-6ba0c9981ae4', '74fe5dc9-8b18-4aae-aa0b-1be8b916ce48');
INSERT INTO public.composite_role (composite, child_role) VALUES ('a55a6883-a186-4dad-aa5f-6ba0c9981ae4', '46b0183e-5de1-43f4-ba70-c79e0abb1985');
INSERT INTO public.composite_role (composite, child_role) VALUES ('a55a6883-a186-4dad-aa5f-6ba0c9981ae4', '028afee7-45ff-4083-ab30-79abe3182b57');
INSERT INTO public.composite_role (composite, child_role) VALUES ('a55a6883-a186-4dad-aa5f-6ba0c9981ae4', '781ead0c-671a-4fa6-9eba-4fd4b6bf7164');
INSERT INTO public.composite_role (composite, child_role) VALUES ('a55a6883-a186-4dad-aa5f-6ba0c9981ae4', '95fe4171-e894-42f2-a017-280bf0ce59b7');
INSERT INTO public.composite_role (composite, child_role) VALUES ('a55a6883-a186-4dad-aa5f-6ba0c9981ae4', '509c1631-d057-435b-8efa-431cc52eba9c');
INSERT INTO public.composite_role (composite, child_role) VALUES ('a55a6883-a186-4dad-aa5f-6ba0c9981ae4', 'c2dd63a3-0e64-428f-8423-6adc5fed67d7');
INSERT INTO public.composite_role (composite, child_role) VALUES ('a55a6883-a186-4dad-aa5f-6ba0c9981ae4', '7525b9d3-3ca6-4ddd-ab29-97884b4aa4d3');
INSERT INTO public.composite_role (composite, child_role) VALUES ('a55a6883-a186-4dad-aa5f-6ba0c9981ae4', '6db75b89-b61f-40ef-bfce-deea1f450fd1');
INSERT INTO public.composite_role (composite, child_role) VALUES ('a55a6883-a186-4dad-aa5f-6ba0c9981ae4', '2dd463bd-2b9e-4e4e-a4f8-21810e2ae03e');
INSERT INTO public.composite_role (composite, child_role) VALUES ('a0bcc01d-16f2-4d00-89bf-1345f66ad378', '7525b9d3-3ca6-4ddd-ab29-97884b4aa4d3');
INSERT INTO public.composite_role (composite, child_role) VALUES ('7cff71ad-de17-4421-87b9-f09fa2e6b979', 'c2dd63a3-0e64-428f-8423-6adc5fed67d7');
INSERT INTO public.composite_role (composite, child_role) VALUES ('7cff71ad-de17-4421-87b9-f09fa2e6b979', '2dd463bd-2b9e-4e4e-a4f8-21810e2ae03e');
INSERT INTO public.composite_role (composite, child_role) VALUES ('06800265-af1b-4d4c-95b7-65057c649bf9', '004fce19-5326-43d5-beae-f3e2ccb270fc');
INSERT INTO public.composite_role (composite, child_role) VALUES ('06800265-af1b-4d4c-95b7-65057c649bf9', 'db3d8936-8c63-4875-95b4-491a88c082f2');
INSERT INTO public.composite_role (composite, child_role) VALUES ('06800265-af1b-4d4c-95b7-65057c649bf9', '7110ace8-2f8c-4395-b4f3-f9aeff21853a');
INSERT INTO public.composite_role (composite, child_role) VALUES ('06800265-af1b-4d4c-95b7-65057c649bf9', '658acbab-da31-4644-beed-4fd7dafe678d');
INSERT INTO public.composite_role (composite, child_role) VALUES ('06800265-af1b-4d4c-95b7-65057c649bf9', '155bc937-e097-4ae6-81c8-e9ccbac71eeb');
INSERT INTO public.composite_role (composite, child_role) VALUES ('06800265-af1b-4d4c-95b7-65057c649bf9', '07b441fe-0066-4b6e-a72e-fa62570ba969');
INSERT INTO public.composite_role (composite, child_role) VALUES ('06800265-af1b-4d4c-95b7-65057c649bf9', 'c3ca71de-8fc9-45d3-9294-edd9ee5c3410');
INSERT INTO public.composite_role (composite, child_role) VALUES ('06800265-af1b-4d4c-95b7-65057c649bf9', '2501d995-65bd-457f-a7f4-93b2d4d8679d');
INSERT INTO public.composite_role (composite, child_role) VALUES ('06800265-af1b-4d4c-95b7-65057c649bf9', '7b53fb00-677c-4f69-847a-865901758d4b');
INSERT INTO public.composite_role (composite, child_role) VALUES ('06800265-af1b-4d4c-95b7-65057c649bf9', 'dae7852a-74a0-4d89-9eb7-09a573b04108');
INSERT INTO public.composite_role (composite, child_role) VALUES ('06800265-af1b-4d4c-95b7-65057c649bf9', '775fb967-c9ad-4d67-a339-11c893002b4d');
INSERT INTO public.composite_role (composite, child_role) VALUES ('06800265-af1b-4d4c-95b7-65057c649bf9', '91a137cb-4fa0-42d4-89eb-c8c6b72e76e4');
INSERT INTO public.composite_role (composite, child_role) VALUES ('06800265-af1b-4d4c-95b7-65057c649bf9', 'a925a7eb-8e76-4f09-876f-b84ba2cc14ff');
INSERT INTO public.composite_role (composite, child_role) VALUES ('06800265-af1b-4d4c-95b7-65057c649bf9', '221a675a-0348-4e08-a33c-f618fc0daa06');
INSERT INTO public.composite_role (composite, child_role) VALUES ('06800265-af1b-4d4c-95b7-65057c649bf9', 'd26865dc-7317-4203-9dfa-10d670c6a966');
INSERT INTO public.composite_role (composite, child_role) VALUES ('06800265-af1b-4d4c-95b7-65057c649bf9', '721590b3-0df3-4e41-874c-d640496d879c');
INSERT INTO public.composite_role (composite, child_role) VALUES ('06800265-af1b-4d4c-95b7-65057c649bf9', 'f40f04f7-163a-49b9-a11d-686cb797b906');
INSERT INTO public.composite_role (composite, child_role) VALUES ('658acbab-da31-4644-beed-4fd7dafe678d', 'd26865dc-7317-4203-9dfa-10d670c6a966');
INSERT INTO public.composite_role (composite, child_role) VALUES ('7110ace8-2f8c-4395-b4f3-f9aeff21853a', '221a675a-0348-4e08-a33c-f618fc0daa06');
INSERT INTO public.composite_role (composite, child_role) VALUES ('7110ace8-2f8c-4395-b4f3-f9aeff21853a', 'f40f04f7-163a-49b9-a11d-686cb797b906');
INSERT INTO public.composite_role (composite, child_role) VALUES ('43d9eeda-d8c0-46e2-bc15-1b7049bd3824', '173e686b-0671-4751-acd7-b7f0784624ee');
INSERT INTO public.composite_role (composite, child_role) VALUES ('1539b57d-aa2f-4c67-8ff6-1c08047deb92', 'a8635269-aa56-407e-bd36-a7f94e824fad');
INSERT INTO public.composite_role (composite, child_role) VALUES ('a55a6883-a186-4dad-aa5f-6ba0c9981ae4', '03425469-0e84-48c3-ab00-fef0d2b3c957');
INSERT INTO public.composite_role (composite, child_role) VALUES ('06800265-af1b-4d4c-95b7-65057c649bf9', 'b518f283-f92f-4c4c-8dd1-a813a4db1c28');


--
-- TOC entry 4166 (class 0 OID 16508)
-- Dependencies: 240
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) VALUES ('46e2460c-2381-4e6e-a70c-c021410f88d7', NULL, 'password', 'c2892a6b-4d50-4730-90c4-116e2fc8fadc', 1683126063123, NULL, '{"value":"Q5187x4A9+5DrShRqN45cfLgZshvdzBOveAhVxfns+Z4h8H/YkkolX6rNoTT5unidjeTol7VUnU18dFw6OyMgw==","salt":"OeMLOe5zIr4+/Lm4mPjT8Q==","additionalParameters":{}}', '{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}', 10);
INSERT INTO public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) VALUES ('db2b1060-8f09-4552-a6d4-b1360a602143', NULL, 'password', '1ed2fbca-d650-4284-9917-5416b8d44bd8', 1683127327783, NULL, '{"value":"pjb5gSWvWaQbKNkX6OEH3Mt+Aff9MNFC0d1ZVsa6/lbShXSJYOXeIgtN+EuPqvuUcYJ9bTwkjo6NXrwdic6RpQ==","salt":"Fi9A7eaV2JOHLs91Uv9E7g==","additionalParameters":{}}', '{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}', 10);
INSERT INTO public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) VALUES ('54bed855-14d7-4d96-8515-b177e6004f53', NULL, 'password', 'adc23cb0-f482-44c9-a518-9fc4047cf6bb', 1683127412270, NULL, '{"value":"A7flZCK3XpqZAh96XEizzI8lV9OmMC/dSrtUMh2kx2qlyqC1TwCg45J07EcJo/Ahv9hNGonUHWk9qZBJ5Tt6pQ==","salt":"HGkXMj0PAzOQHd/PEgcYaQ==","additionalParameters":{}}', '{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}', 10);
INSERT INTO public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) VALUES ('aed70f33-e313-455b-955d-44f47dfe7a3a', NULL, 'password', '1d933423-4975-4aef-909d-48239ef368ae', 1683127489062, NULL, '{"value":"X6syESeXba4f9IWTa229LGyWTmEwkW0iTuR3VmvJndHi9sTDKg5uYb9jdOwUw71ttBOvBkPOt+Iavi+Kmt3yWw==","salt":"CNL1ZJDQVGwVa54ykPYZLg==","additionalParameters":{}}', '{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}', 10);
INSERT INTO public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) VALUES ('29806106-f36f-456b-902b-2077346a0666', NULL, 'password', '33c2c7af-640b-4e4b-9682-681fc929d924', 1683127507854, NULL, '{"value":"PACqlRPhPJmgjPMCEuaui4L3AwM/8I2YAMT9q4bq8ZkWQdJQ7j82L6XA2RRVeDv1Ilk51FrhQ7F4FcrppzDbhw==","salt":"04kb13ZCUqsX2vqs83dEUw==","additionalParameters":{}}', '{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}', 10);


--
-- TOC entry 4167 (class 0 OID 16513)
-- Dependencies: 241
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.0.0.Final-KEYCLOAK-5461', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.0.0.Final.xml', '2023-05-03 15:00:59.479286', 1, 'EXECUTED', '7:4e70412f24a3f382c82183742ec79317', 'createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.0.0.Final-KEYCLOAK-5461', 'sthorger@redhat.com', 'META-INF/db2-jpa-changelog-1.0.0.Final.xml', '2023-05-03 15:00:59.48892', 2, 'MARK_RAN', '7:cb16724583e9675711801c6875114f28', 'createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.1.0.Beta1', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.1.0.Beta1.xml', '2023-05-03 15:00:59.517447', 3, 'EXECUTED', '7:0310eb8ba07cec616460794d42ade0fa', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.1.0.Final', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.1.0.Final.xml', '2023-05-03 15:00:59.520726', 4, 'EXECUTED', '7:5d25857e708c3233ef4439df1f93f012', 'renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.2.0.Beta1', 'psilva@redhat.com', 'META-INF/jpa-changelog-1.2.0.Beta1.xml', '2023-05-03 15:00:59.588615', 5, 'EXECUTED', '7:c7a54a1041d58eb3817a4a883b4d4e84', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.2.0.Beta1', 'psilva@redhat.com', 'META-INF/db2-jpa-changelog-1.2.0.Beta1.xml', '2023-05-03 15:00:59.591569', 6, 'MARK_RAN', '7:2e01012df20974c1c2a605ef8afe25b7', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.2.0.RC1', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.2.0.CR1.xml', '2023-05-03 15:00:59.658561', 7, 'EXECUTED', '7:0f08df48468428e0f30ee59a8ec01a41', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.2.0.RC1', 'bburke@redhat.com', 'META-INF/db2-jpa-changelog-1.2.0.CR1.xml', '2023-05-03 15:00:59.661782', 8, 'MARK_RAN', '7:a77ea2ad226b345e7d689d366f185c8c', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.2.0.Final', 'keycloak', 'META-INF/jpa-changelog-1.2.0.Final.xml', '2023-05-03 15:00:59.665861', 9, 'EXECUTED', '7:a3377a2059aefbf3b90ebb4c4cc8e2ab', 'update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.3.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.3.0.xml', '2023-05-03 15:00:59.73381', 10, 'EXECUTED', '7:04c1dbedc2aa3e9756d1a1668e003451', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.4.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.4.0.xml', '2023-05-03 15:00:59.771265', 11, 'EXECUTED', '7:36ef39ed560ad07062d956db861042ba', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.4.0', 'bburke@redhat.com', 'META-INF/db2-jpa-changelog-1.4.0.xml', '2023-05-03 15:00:59.773557', 12, 'MARK_RAN', '7:d909180b2530479a716d3f9c9eaea3d7', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.5.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.5.0.xml', '2023-05-03 15:00:59.783558', 13, 'EXECUTED', '7:cf12b04b79bea5152f165eb41f3955f6', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.6.1_from15', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2023-05-03 15:00:59.797802', 14, 'EXECUTED', '7:7e32c8f05c755e8675764e7d5f514509', 'addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.6.1_from16-pre', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2023-05-03 15:00:59.799553', 15, 'MARK_RAN', '7:980ba23cc0ec39cab731ce903dd01291', 'delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.6.1_from16', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2023-05-03 15:00:59.801238', 16, 'MARK_RAN', '7:2fa220758991285312eb84f3b4ff5336', 'dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.6.1', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2023-05-03 15:00:59.803352', 17, 'EXECUTED', '7:d41d8cd98f00b204e9800998ecf8427e', 'empty', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.7.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.7.0.xml', '2023-05-03 15:00:59.835644', 18, 'EXECUTED', '7:91ace540896df890cc00a0490ee52bbc', 'createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.8.0', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.8.0.xml', '2023-05-03 15:00:59.86339', 19, 'EXECUTED', '7:c31d1646dfa2618a9335c00e07f89f24', 'addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.8.0-2', 'keycloak', 'META-INF/jpa-changelog-1.8.0.xml', '2023-05-03 15:00:59.866913', 20, 'EXECUTED', '7:df8bc21027a4f7cbbb01f6344e89ce07', 'dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part1', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2023-05-03 15:01:00.263864', 45, 'EXECUTED', '7:6a48ce645a3525488a90fbf76adf3bb3', 'addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.8.0', 'mposolda@redhat.com', 'META-INF/db2-jpa-changelog-1.8.0.xml', '2023-05-03 15:00:59.869137', 21, 'MARK_RAN', '7:f987971fe6b37d963bc95fee2b27f8df', 'addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.8.0-2', 'keycloak', 'META-INF/db2-jpa-changelog-1.8.0.xml', '2023-05-03 15:00:59.871603', 22, 'MARK_RAN', '7:df8bc21027a4f7cbbb01f6344e89ce07', 'dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.9.0', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.9.0.xml', '2023-05-03 15:00:59.887145', 23, 'EXECUTED', '7:ed2dc7f799d19ac452cbcda56c929e47', 'update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.9.1', 'keycloak', 'META-INF/jpa-changelog-1.9.1.xml', '2023-05-03 15:00:59.892115', 24, 'EXECUTED', '7:80b5db88a5dda36ece5f235be8757615', 'modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.9.1', 'keycloak', 'META-INF/db2-jpa-changelog-1.9.1.xml', '2023-05-03 15:00:59.894037', 25, 'MARK_RAN', '7:1437310ed1305a9b93f8848f301726ce', 'modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.9.2', 'keycloak', 'META-INF/jpa-changelog-1.9.2.xml', '2023-05-03 15:00:59.92225', 26, 'EXECUTED', '7:b82ffb34850fa0836be16deefc6a87c4', 'createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-2.0.0', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-2.0.0.xml', '2023-05-03 15:00:59.982063', 27, 'EXECUTED', '7:9cc98082921330d8d9266decdd4bd658', 'createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-2.5.1', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-2.5.1.xml', '2023-05-03 15:00:59.988349', 28, 'EXECUTED', '7:03d64aeed9cb52b969bd30a7ac0db57e', 'update tableName=RESOURCE_SERVER_POLICY', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.1.0-KEYCLOAK-5461', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.1.0.xml', '2023-05-03 15:01:00.049626', 29, 'EXECUTED', '7:f1f9fd8710399d725b780f463c6b21cd', 'createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.2.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.2.0.xml', '2023-05-03 15:01:00.060988', 30, 'EXECUTED', '7:53188c3eb1107546e6f765835705b6c1', 'addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.3.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.3.0.xml', '2023-05-03 15:01:00.072961', 31, 'EXECUTED', '7:d6e6f3bc57a0c5586737d1351725d4d4', 'createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.4.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.4.0.xml', '2023-05-03 15:01:00.07641', 32, 'EXECUTED', '7:454d604fbd755d9df3fd9c6329043aa5', 'customChange', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.5.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2023-05-03 15:01:00.080822', 33, 'EXECUTED', '7:57e98a3077e29caf562f7dbf80c72600', 'customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.5.0-unicode-oracle', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2023-05-03 15:01:00.08258', 34, 'MARK_RAN', '7:e4c7e8f2256210aee71ddc42f538b57a', 'modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.5.0-unicode-other-dbs', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2023-05-03 15:01:00.104434', 35, 'EXECUTED', '7:09a43c97e49bc626460480aa1379b522', 'modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.5.0-duplicate-email-support', 'slawomir@dabek.name', 'META-INF/jpa-changelog-2.5.0.xml', '2023-05-03 15:01:00.108319', 36, 'EXECUTED', '7:26bfc7c74fefa9126f2ce702fb775553', 'addColumn tableName=REALM', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.5.0-unique-group-names', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2023-05-03 15:01:00.113284', 37, 'EXECUTED', '7:a161e2ae671a9020fff61e996a207377', 'addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.5.1', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.5.1.xml', '2023-05-03 15:01:00.116236', 38, 'EXECUTED', '7:37fc1781855ac5388c494f1442b3f717', 'addColumn tableName=FED_USER_CONSENT', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.0.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-3.0.0.xml', '2023-05-03 15:01:00.119148', 39, 'EXECUTED', '7:13a27db0dae6049541136adad7261d27', 'addColumn tableName=IDENTITY_PROVIDER', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.2.0-fix', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2023-05-03 15:01:00.120759', 40, 'MARK_RAN', '7:550300617e3b59e8af3a6294df8248a3', 'addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.2.0-fix-with-keycloak-5416', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2023-05-03 15:01:00.122335', 41, 'MARK_RAN', '7:e3a9482b8931481dc2772a5c07c44f17', 'dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.2.0-fix-offline-sessions', 'hmlnarik', 'META-INF/jpa-changelog-3.2.0.xml', '2023-05-03 15:01:00.125962', 42, 'EXECUTED', '7:72b07d85a2677cb257edb02b408f332d', 'customChange', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.2.0-fixed', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2023-05-03 15:01:00.256425', 43, 'EXECUTED', '7:a72a7858967bd414835d19e04d880312', 'addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.3.0', 'keycloak', 'META-INF/jpa-changelog-3.3.0.xml', '2023-05-03 15:01:00.260198', 44, 'EXECUTED', '7:94edff7cf9ce179e7e85f0cd78a3cf2c', 'addColumn tableName=USER_ENTITY', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2023-05-03 15:01:00.267237', 46, 'EXECUTED', '7:e64b5dcea7db06077c6e57d3b9e5ca14', 'customChange', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2023-05-03 15:01:00.268802', 47, 'MARK_RAN', '7:fd8cf02498f8b1e72496a20afc75178c', 'dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2023-05-03 15:01:00.296867', 48, 'EXECUTED', '7:542794f25aa2b1fbabb7e577d6646319', 'addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authn-3.4.0.CR1-refresh-token-max-reuse', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2023-05-03 15:01:00.300324', 49, 'EXECUTED', '7:edad604c882df12f74941dac3cc6d650', 'addColumn tableName=REALM', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.4.0', 'keycloak', 'META-INF/jpa-changelog-3.4.0.xml', '2023-05-03 15:01:00.336864', 50, 'EXECUTED', '7:0f88b78b7b46480eb92690cbf5e44900', 'addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.4.0-KEYCLOAK-5230', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-3.4.0.xml', '2023-05-03 15:01:00.36394', 51, 'EXECUTED', '7:d560e43982611d936457c327f872dd59', 'createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.4.1', 'psilva@redhat.com', 'META-INF/jpa-changelog-3.4.1.xml', '2023-05-03 15:01:00.367494', 52, 'EXECUTED', '7:c155566c42b4d14ef07059ec3b3bbd8e', 'modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.4.2', 'keycloak', 'META-INF/jpa-changelog-3.4.2.xml', '2023-05-03 15:01:00.369913', 53, 'EXECUTED', '7:b40376581f12d70f3c89ba8ddf5b7dea', 'update tableName=REALM', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.4.2-KEYCLOAK-5172', 'mkanis@redhat.com', 'META-INF/jpa-changelog-3.4.2.xml', '2023-05-03 15:01:00.371994', 54, 'EXECUTED', '7:a1132cc395f7b95b3646146c2e38f168', 'update tableName=CLIENT', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.0.0-KEYCLOAK-6335', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2023-05-03 15:01:00.376877', 55, 'EXECUTED', '7:d8dc5d89c789105cfa7ca0e82cba60af', 'createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.0.0-CLEANUP-UNUSED-TABLE', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2023-05-03 15:01:00.380467', 56, 'EXECUTED', '7:7822e0165097182e8f653c35517656a3', 'dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.0.0-KEYCLOAK-6228', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2023-05-03 15:01:00.396571', 57, 'EXECUTED', '7:c6538c29b9c9a08f9e9ea2de5c2b6375', 'dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.0.0-KEYCLOAK-5579-fixed', 'mposolda@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2023-05-03 15:01:00.461477', 58, 'EXECUTED', '7:6d4893e36de22369cf73bcb051ded875', 'dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-4.0.0.CR1', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-4.0.0.CR1.xml', '2023-05-03 15:01:00.483455', 59, 'EXECUTED', '7:57960fc0b0f0dd0563ea6f8b2e4a1707', 'createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-4.0.0.Beta3', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-4.0.0.Beta3.xml', '2023-05-03 15:01:00.488737', 60, 'EXECUTED', '7:2b4b8bff39944c7097977cc18dbceb3b', 'addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-4.2.0.Final', 'mhajas@redhat.com', 'META-INF/jpa-changelog-authz-4.2.0.Final.xml', '2023-05-03 15:01:00.495495', 61, 'EXECUTED', '7:2aa42a964c59cd5b8ca9822340ba33a8', 'createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-4.2.0.Final-KEYCLOAK-9944', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-authz-4.2.0.Final.xml', '2023-05-03 15:01:00.500892', 62, 'EXECUTED', '7:9ac9e58545479929ba23f4a3087a0346', 'addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.2.0-KEYCLOAK-6313', 'wadahiro@gmail.com', 'META-INF/jpa-changelog-4.2.0.xml', '2023-05-03 15:01:00.504006', 63, 'EXECUTED', '7:14d407c35bc4fe1976867756bcea0c36', 'addColumn tableName=REQUIRED_ACTION_PROVIDER', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.3.0-KEYCLOAK-7984', 'wadahiro@gmail.com', 'META-INF/jpa-changelog-4.3.0.xml', '2023-05-03 15:01:00.506302', 64, 'EXECUTED', '7:241a8030c748c8548e346adee548fa93', 'update tableName=REQUIRED_ACTION_PROVIDER', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.6.0-KEYCLOAK-7950', 'psilva@redhat.com', 'META-INF/jpa-changelog-4.6.0.xml', '2023-05-03 15:01:00.508562', 65, 'EXECUTED', '7:7d3182f65a34fcc61e8d23def037dc3f', 'update tableName=RESOURCE_SERVER_RESOURCE', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.6.0-KEYCLOAK-8377', 'keycloak', 'META-INF/jpa-changelog-4.6.0.xml', '2023-05-03 15:01:00.519209', 66, 'EXECUTED', '7:b30039e00a0b9715d430d1b0636728fa', 'createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.6.0-KEYCLOAK-8555', 'gideonray@gmail.com', 'META-INF/jpa-changelog-4.6.0.xml', '2023-05-03 15:01:00.524108', 67, 'EXECUTED', '7:3797315ca61d531780f8e6f82f258159', 'createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.7.0-KEYCLOAK-1267', 'sguilhen@redhat.com', 'META-INF/jpa-changelog-4.7.0.xml', '2023-05-03 15:01:00.52754', 68, 'EXECUTED', '7:c7aa4c8d9573500c2d347c1941ff0301', 'addColumn tableName=REALM', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.7.0-KEYCLOAK-7275', 'keycloak', 'META-INF/jpa-changelog-4.7.0.xml', '2023-05-03 15:01:00.53744', 69, 'EXECUTED', '7:b207faee394fc074a442ecd42185a5dd', 'renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.8.0-KEYCLOAK-8835', 'sguilhen@redhat.com', 'META-INF/jpa-changelog-4.8.0.xml', '2023-05-03 15:01:00.542017', 70, 'EXECUTED', '7:ab9a9762faaba4ddfa35514b212c4922', 'addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-7.0.0-KEYCLOAK-10443', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-7.0.0.xml', '2023-05-03 15:01:00.546067', 71, 'EXECUTED', '7:b9710f74515a6ccb51b72dc0d19df8c4', 'addColumn tableName=RESOURCE_SERVER', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('8.0.0-adding-credential-columns', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2023-05-03 15:01:00.550508', 72, 'EXECUTED', '7:ec9707ae4d4f0b7452fee20128083879', 'addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('8.0.0-updating-credential-data-not-oracle', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2023-05-03 15:01:00.554523', 73, 'EXECUTED', '7:03b3f4b264c3c68ba082250a80b74216', 'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('8.0.0-updating-credential-data-oracle', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2023-05-03 15:01:00.55619', 74, 'MARK_RAN', '7:64c5728f5ca1f5aa4392217701c4fe23', 'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('8.0.0-credential-cleanup-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2023-05-03 15:01:00.564726', 75, 'EXECUTED', '7:b48da8c11a3d83ddd6b7d0c8c2219345', 'dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('8.0.0-resource-tag-support', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2023-05-03 15:01:00.570809', 76, 'EXECUTED', '7:a73379915c23bfad3e8f5c6d5c0aa4bd', 'addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.0-always-display-client', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2023-05-03 15:01:00.573984', 77, 'EXECUTED', '7:39e0073779aba192646291aa2332493d', 'addColumn tableName=CLIENT', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.0-drop-constraints-for-column-increase', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2023-05-03 15:01:00.575758', 78, 'MARK_RAN', '7:81f87368f00450799b4bf42ea0b3ec34', 'dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.0-increase-column-size-federated-fk', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2023-05-03 15:01:00.588856', 79, 'EXECUTED', '7:20b37422abb9fb6571c618148f013a15', 'modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.0-recreate-constraints-after-column-increase', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2023-05-03 15:01:00.591006', 80, 'MARK_RAN', '7:1970bb6cfb5ee800736b95ad3fb3c78a', 'addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.1-add-index-to-client.client_id', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2023-05-03 15:01:00.596584', 81, 'EXECUTED', '7:45d9b25fc3b455d522d8dcc10a0f4c80', 'createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.1-KEYCLOAK-12579-drop-constraints', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2023-05-03 15:01:00.598761', 82, 'MARK_RAN', '7:890ae73712bc187a66c2813a724d037f', 'dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.1-KEYCLOAK-12579-add-not-null-constraint', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2023-05-03 15:01:00.603124', 83, 'EXECUTED', '7:0a211980d27fafe3ff50d19a3a29b538', 'addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.1-KEYCLOAK-12579-recreate-constraints', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2023-05-03 15:01:00.605261', 84, 'MARK_RAN', '7:a161e2ae671a9020fff61e996a207377', 'addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.1-add-index-to-events', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2023-05-03 15:01:00.611728', 85, 'EXECUTED', '7:01c49302201bdf815b0a18d1f98a55dc', 'createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('map-remove-ri', 'keycloak', 'META-INF/jpa-changelog-11.0.0.xml', '2023-05-03 15:01:00.615585', 86, 'EXECUTED', '7:3dace6b144c11f53f1ad2c0361279b86', 'dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('map-remove-ri', 'keycloak', 'META-INF/jpa-changelog-12.0.0.xml', '2023-05-03 15:01:00.620308', 87, 'EXECUTED', '7:578d0b92077eaf2ab95ad0ec087aa903', 'dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...', '', NULL, '3.5.4', NULL, NULL, '3126059235');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('12.1.0-add-realm-localization-table', 'keycloak', 'META-INF/jpa-changelog-12.0.0.xml', '2023-05-03 15:01:00.628948', 88, 'EXECUTED', '7:c95abe90d962c57a09ecaee57972835d', 'createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS', '', NULL, '3.5.4', NULL, NULL, '3126059235');


--
-- TOC entry 4168 (class 0 OID 16518)
-- Dependencies: 242
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.databasechangeloglock (id, locked, lockgranted, lockedby) VALUES (1, false, NULL, NULL);
INSERT INTO public.databasechangeloglock (id, locked, lockgranted, lockedby) VALUES (1000, false, NULL, NULL);
INSERT INTO public.databasechangeloglock (id, locked, lockgranted, lockedby) VALUES (1001, false, NULL, NULL);


--
-- TOC entry 4169 (class 0 OID 16521)
-- Dependencies: 243
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('master', 'f49b1a89-50cf-49d5-a83a-f0114459f367', false);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('master', '86ff35aa-e6a2-4eae-85e6-cbe8861a9c2e', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('master', 'f141d59d-1c7a-49d8-a3ce-566db1a2d612', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('master', '50d34770-cf89-4dd0-90c3-81f216bcb84f', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('master', '3d130846-07fd-49e3-8977-58ce8f3db9ca', false);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('master', '2fd3e2bf-b67f-498d-97f9-7ec9b2cd01ae', false);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('master', '4f187629-96c5-4696-9817-e23d18019241', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('master', '8f3eca4b-2621-407b-8499-4e00b57caae8', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('master', '6747b15d-6950-4e9e-992a-fce71215ad12', false);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('clin', 'a0093c54-0826-4666-9557-3233e6be7ff7', false);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('clin', '1bc050b5-b982-4107-8b55-3500654c5426', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('clin', 'ff25c7ed-164d-4556-85d9-193193c025ca', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('clin', '85f5d4de-1159-4385-b47a-2624724fb2cf', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('clin', '72f04a91-426c-4691-bddb-58ced7f53b0a', false);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('clin', '614d16e8-4c8f-4a48-a1d1-91d0bf237195', false);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('clin', 'fd7a4932-739c-46c2-93d3-c43e3d3b4a22', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('clin', '5469a308-5768-474c-9ab6-39e98a21b841', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('clin', '11938e7f-466f-4e38-8e1b-dcd01f70a0fd', false);


--
-- TOC entry 4170 (class 0 OID 16525)
-- Dependencies: 244
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4171 (class 0 OID 16530)
-- Dependencies: 245
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4172 (class 0 OID 16535)
-- Dependencies: 246
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4173 (class 0 OID 16540)
-- Dependencies: 247
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4174 (class 0 OID 16543)
-- Dependencies: 248
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4175 (class 0 OID 16548)
-- Dependencies: 249
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4176 (class 0 OID 16551)
-- Dependencies: 250
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4177 (class 0 OID 16557)
-- Dependencies: 251
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4178 (class 0 OID 16560)
-- Dependencies: 252
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4179 (class 0 OID 16565)
-- Dependencies: 253
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4180 (class 0 OID 16570)
-- Dependencies: 254
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.group_attribute (id, name, value, group_id) VALUES ('592c2b5d-86b7-45b4-9246-c566dcb292ec', 'fhir_organization_id', 'CHUS', '43317539-da80-4603-9ff0-75ebe43e2dd1');
INSERT INTO public.group_attribute (id, name, value, group_id) VALUES ('a39261ff-8e0b-4ba6-91ef-ee868da34199', 'fhir_organization_id', 'CHUSJ', '0002f2ea-a61f-4531-bcc5-cdeec94a7762');
INSERT INTO public.group_attribute (id, name, value, group_id) VALUES ('e8953c52-8075-4c86-b7d7-413b6811b4ad', 'fhir_organization_id', 'LDM-CHUS', '916741d3-5dae-4a73-91a0-a4a28f845bc3');
INSERT INTO public.group_attribute (id, name, value, group_id) VALUES ('0abd0763-d103-4e75-b280-d1abd4cbc054', 'fhir_organization_id', 'LDM-CHUSJ', '7efc60cc-14b8-411e-84e8-04b683e63ae9');


--
-- TOC entry 4181 (class 0 OID 16576)
-- Dependencies: 255
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4182 (class 0 OID 16579)
-- Dependencies: 256
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4183 (class 0 OID 16590)
-- Dependencies: 257
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4184 (class 0 OID 16595)
-- Dependencies: 258
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4185 (class 0 OID 16600)
-- Dependencies: 259
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4186 (class 0 OID 16605)
-- Dependencies: 260
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.keycloak_group (id, name, parent_group, realm_id) VALUES ('0002f2ea-a61f-4531-bcc5-cdeec94a7762', 'CHUSJ', ' ', 'clin');
INSERT INTO public.keycloak_group (id, name, parent_group, realm_id) VALUES ('43317539-da80-4603-9ff0-75ebe43e2dd1', 'CHUS', ' ', 'clin');
INSERT INTO public.keycloak_group (id, name, parent_group, realm_id) VALUES ('7efc60cc-14b8-411e-84e8-04b683e63ae9', 'LDM-CHUSJ', ' ', 'clin');
INSERT INTO public.keycloak_group (id, name, parent_group, realm_id) VALUES ('916741d3-5dae-4a73-91a0-a4a28f845bc3', 'LDM-CHUS', ' ', 'clin');


--
-- TOC entry 4187 (class 0 OID 16608)
-- Dependencies: 261
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('a55a6883-a186-4dad-aa5f-6ba0c9981ae4', 'master', false, '${role_admin}', 'admin', 'master', NULL, 'master');
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('33a898bf-3cb2-463d-89b1-1ce2dff1c25f', 'master', false, '${role_create-realm}', 'create-realm', 'master', NULL, 'master');
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('5df22785-96e5-4e9d-8b78-b23dc7d79116', '666fea7e-1491-48d3-83ac-229faaaa9aa6', true, '${role_create-client}', 'create-client', 'master', '666fea7e-1491-48d3-83ac-229faaaa9aa6', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('6cbfb24a-4d55-4d16-867b-c68ba9fded0c', '666fea7e-1491-48d3-83ac-229faaaa9aa6', true, '${role_view-realm}', 'view-realm', 'master', '666fea7e-1491-48d3-83ac-229faaaa9aa6', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('4ef8f404-8cbb-40d0-aca9-c99e493b651b', '666fea7e-1491-48d3-83ac-229faaaa9aa6', true, '${role_view-users}', 'view-users', 'master', '666fea7e-1491-48d3-83ac-229faaaa9aa6', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('bfb9a7bd-b571-4ab2-a675-2175d9103892', '666fea7e-1491-48d3-83ac-229faaaa9aa6', true, '${role_view-clients}', 'view-clients', 'master', '666fea7e-1491-48d3-83ac-229faaaa9aa6', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('80980eb3-b7c7-4796-a849-db4c47aed94e', '666fea7e-1491-48d3-83ac-229faaaa9aa6', true, '${role_view-events}', 'view-events', 'master', '666fea7e-1491-48d3-83ac-229faaaa9aa6', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('c20b8e05-e4fd-4b37-995a-a2bfdc637e51', '666fea7e-1491-48d3-83ac-229faaaa9aa6', true, '${role_view-identity-providers}', 'view-identity-providers', 'master', '666fea7e-1491-48d3-83ac-229faaaa9aa6', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('3473fb60-b544-42d2-b6da-d9e00f81f0c2', '666fea7e-1491-48d3-83ac-229faaaa9aa6', true, '${role_view-authorization}', 'view-authorization', 'master', '666fea7e-1491-48d3-83ac-229faaaa9aa6', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('8bdf4151-e2a8-4b7d-a154-779d00b39a8d', '666fea7e-1491-48d3-83ac-229faaaa9aa6', true, '${role_manage-realm}', 'manage-realm', 'master', '666fea7e-1491-48d3-83ac-229faaaa9aa6', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('c7ec562a-e1a1-475e-b9c0-a69b1e9949f1', '666fea7e-1491-48d3-83ac-229faaaa9aa6', true, '${role_manage-users}', 'manage-users', 'master', '666fea7e-1491-48d3-83ac-229faaaa9aa6', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('273366be-ea57-4e4a-a4c8-b8d9c1061265', '666fea7e-1491-48d3-83ac-229faaaa9aa6', true, '${role_manage-clients}', 'manage-clients', 'master', '666fea7e-1491-48d3-83ac-229faaaa9aa6', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('efcb05dd-feee-4d94-bf59-1ff97e75e737', '666fea7e-1491-48d3-83ac-229faaaa9aa6', true, '${role_manage-events}', 'manage-events', 'master', '666fea7e-1491-48d3-83ac-229faaaa9aa6', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('f502d79f-c1be-4557-97c8-9da83a34d6bc', '666fea7e-1491-48d3-83ac-229faaaa9aa6', true, '${role_manage-identity-providers}', 'manage-identity-providers', 'master', '666fea7e-1491-48d3-83ac-229faaaa9aa6', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('7c7feea0-e6a7-4efd-8174-9d27fd502405', '666fea7e-1491-48d3-83ac-229faaaa9aa6', true, '${role_manage-authorization}', 'manage-authorization', 'master', '666fea7e-1491-48d3-83ac-229faaaa9aa6', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('e0acdb97-9744-4560-8dc5-92031f1a678b', '666fea7e-1491-48d3-83ac-229faaaa9aa6', true, '${role_query-users}', 'query-users', 'master', '666fea7e-1491-48d3-83ac-229faaaa9aa6', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('dfc982d8-0579-4301-97ee-789b3054ec02', '666fea7e-1491-48d3-83ac-229faaaa9aa6', true, '${role_query-clients}', 'query-clients', 'master', '666fea7e-1491-48d3-83ac-229faaaa9aa6', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('4582ffd3-3c4a-47ae-b457-9b0bfb112ccf', '666fea7e-1491-48d3-83ac-229faaaa9aa6', true, '${role_query-realms}', 'query-realms', 'master', '666fea7e-1491-48d3-83ac-229faaaa9aa6', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('569cf9aa-9ea5-41fb-8729-d8abc74a1862', '666fea7e-1491-48d3-83ac-229faaaa9aa6', true, '${role_query-groups}', 'query-groups', 'master', '666fea7e-1491-48d3-83ac-229faaaa9aa6', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('3df37bdc-beff-4411-bfca-db07a16215f8', '740d7d62-c828-439b-a4c0-6f513354894a', true, '${role_view-profile}', 'view-profile', 'master', '740d7d62-c828-439b-a4c0-6f513354894a', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('d31a5d16-be94-4795-a857-8933093fb18e', '740d7d62-c828-439b-a4c0-6f513354894a', true, '${role_manage-account}', 'manage-account', 'master', '740d7d62-c828-439b-a4c0-6f513354894a', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('7e066a55-2291-424b-bb5f-8688a5200282', '740d7d62-c828-439b-a4c0-6f513354894a', true, '${role_manage-account-links}', 'manage-account-links', 'master', '740d7d62-c828-439b-a4c0-6f513354894a', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('7003d28c-010d-4ec5-9c7d-ca5f0b8887bc', '740d7d62-c828-439b-a4c0-6f513354894a', true, '${role_view-applications}', 'view-applications', 'master', '740d7d62-c828-439b-a4c0-6f513354894a', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('4e4a1af3-1a5c-41ba-8b64-edb01ddbc693', '740d7d62-c828-439b-a4c0-6f513354894a', true, '${role_view-consent}', 'view-consent', 'master', '740d7d62-c828-439b-a4c0-6f513354894a', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('6d7cba7d-066e-4751-a078-43f3002100e4', '740d7d62-c828-439b-a4c0-6f513354894a', true, '${role_manage-consent}', 'manage-consent', 'master', '740d7d62-c828-439b-a4c0-6f513354894a', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('27d29a98-a40b-42f4-b35a-cf815b90e7ff', '740d7d62-c828-439b-a4c0-6f513354894a', true, '${role_delete-account}', 'delete-account', 'master', '740d7d62-c828-439b-a4c0-6f513354894a', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('007e935c-fbd6-4052-8942-d12fcb60eb0d', '9fd6733e-200a-4f4a-bcbc-aad28d5a919a', true, '${role_read-token}', 'read-token', 'master', '9fd6733e-200a-4f4a-bcbc-aad28d5a919a', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('eb3771a7-4553-4129-8d40-f5b2dbd1cb76', '666fea7e-1491-48d3-83ac-229faaaa9aa6', true, '${role_impersonation}', 'impersonation', 'master', '666fea7e-1491-48d3-83ac-229faaaa9aa6', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('bc77550a-7271-4beb-a829-4cec806b23a6', 'master', false, '${role_offline-access}', 'offline_access', 'master', NULL, 'master');
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('65603187-52ff-471f-9248-fd537cdcd9a6', 'master', false, '${role_uma_authorization}', 'uma_authorization', 'master', NULL, 'master');
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('3699aa5e-e80f-48d6-b19e-0b6f213bd58e', '4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', true, '${role_create-client}', 'create-client', 'master', '4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('06078de0-3785-479b-8764-a86bf4179794', '4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', true, '${role_view-realm}', 'view-realm', 'master', '4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('7cff71ad-de17-4421-87b9-f09fa2e6b979', '4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', true, '${role_view-users}', 'view-users', 'master', '4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('a0bcc01d-16f2-4d00-89bf-1345f66ad378', '4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', true, '${role_view-clients}', 'view-clients', 'master', '4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('470459bb-c1c5-4417-992c-97f66f430db8', '4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', true, '${role_view-events}', 'view-events', 'master', '4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('ce42bdc8-f028-4c05-a699-b129df771248', '4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', true, '${role_view-identity-providers}', 'view-identity-providers', 'master', '4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('f747c4ae-4c3f-4fdf-94d6-dbf934055a91', '4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', true, '${role_view-authorization}', 'view-authorization', 'master', '4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('74fe5dc9-8b18-4aae-aa0b-1be8b916ce48', '4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', true, '${role_manage-realm}', 'manage-realm', 'master', '4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('46b0183e-5de1-43f4-ba70-c79e0abb1985', '4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', true, '${role_manage-users}', 'manage-users', 'master', '4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('028afee7-45ff-4083-ab30-79abe3182b57', '4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', true, '${role_manage-clients}', 'manage-clients', 'master', '4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('781ead0c-671a-4fa6-9eba-4fd4b6bf7164', '4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', true, '${role_manage-events}', 'manage-events', 'master', '4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('95fe4171-e894-42f2-a017-280bf0ce59b7', '4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', true, '${role_manage-identity-providers}', 'manage-identity-providers', 'master', '4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('509c1631-d057-435b-8efa-431cc52eba9c', '4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', true, '${role_manage-authorization}', 'manage-authorization', 'master', '4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('c2dd63a3-0e64-428f-8423-6adc5fed67d7', '4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', true, '${role_query-users}', 'query-users', 'master', '4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('7525b9d3-3ca6-4ddd-ab29-97884b4aa4d3', '4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', true, '${role_query-clients}', 'query-clients', 'master', '4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('6db75b89-b61f-40ef-bfce-deea1f450fd1', '4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', true, '${role_query-realms}', 'query-realms', 'master', '4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('2dd463bd-2b9e-4e4e-a4f8-21810e2ae03e', '4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', true, '${role_query-groups}', 'query-groups', 'master', '4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('06800265-af1b-4d4c-95b7-65057c649bf9', '8271513b-5e8c-4b3b-9374-5c477d2010a0', true, '${role_realm-admin}', 'realm-admin', 'clin', '8271513b-5e8c-4b3b-9374-5c477d2010a0', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('004fce19-5326-43d5-beae-f3e2ccb270fc', '8271513b-5e8c-4b3b-9374-5c477d2010a0', true, '${role_create-client}', 'create-client', 'clin', '8271513b-5e8c-4b3b-9374-5c477d2010a0', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('db3d8936-8c63-4875-95b4-491a88c082f2', '8271513b-5e8c-4b3b-9374-5c477d2010a0', true, '${role_view-realm}', 'view-realm', 'clin', '8271513b-5e8c-4b3b-9374-5c477d2010a0', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('7110ace8-2f8c-4395-b4f3-f9aeff21853a', '8271513b-5e8c-4b3b-9374-5c477d2010a0', true, '${role_view-users}', 'view-users', 'clin', '8271513b-5e8c-4b3b-9374-5c477d2010a0', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('658acbab-da31-4644-beed-4fd7dafe678d', '8271513b-5e8c-4b3b-9374-5c477d2010a0', true, '${role_view-clients}', 'view-clients', 'clin', '8271513b-5e8c-4b3b-9374-5c477d2010a0', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('155bc937-e097-4ae6-81c8-e9ccbac71eeb', '8271513b-5e8c-4b3b-9374-5c477d2010a0', true, '${role_view-events}', 'view-events', 'clin', '8271513b-5e8c-4b3b-9374-5c477d2010a0', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('07b441fe-0066-4b6e-a72e-fa62570ba969', '8271513b-5e8c-4b3b-9374-5c477d2010a0', true, '${role_view-identity-providers}', 'view-identity-providers', 'clin', '8271513b-5e8c-4b3b-9374-5c477d2010a0', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('c3ca71de-8fc9-45d3-9294-edd9ee5c3410', '8271513b-5e8c-4b3b-9374-5c477d2010a0', true, '${role_view-authorization}', 'view-authorization', 'clin', '8271513b-5e8c-4b3b-9374-5c477d2010a0', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('2501d995-65bd-457f-a7f4-93b2d4d8679d', '8271513b-5e8c-4b3b-9374-5c477d2010a0', true, '${role_manage-realm}', 'manage-realm', 'clin', '8271513b-5e8c-4b3b-9374-5c477d2010a0', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('7b53fb00-677c-4f69-847a-865901758d4b', '8271513b-5e8c-4b3b-9374-5c477d2010a0', true, '${role_manage-users}', 'manage-users', 'clin', '8271513b-5e8c-4b3b-9374-5c477d2010a0', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('dae7852a-74a0-4d89-9eb7-09a573b04108', '8271513b-5e8c-4b3b-9374-5c477d2010a0', true, '${role_manage-clients}', 'manage-clients', 'clin', '8271513b-5e8c-4b3b-9374-5c477d2010a0', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('775fb967-c9ad-4d67-a339-11c893002b4d', '8271513b-5e8c-4b3b-9374-5c477d2010a0', true, '${role_manage-events}', 'manage-events', 'clin', '8271513b-5e8c-4b3b-9374-5c477d2010a0', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('91a137cb-4fa0-42d4-89eb-c8c6b72e76e4', '8271513b-5e8c-4b3b-9374-5c477d2010a0', true, '${role_manage-identity-providers}', 'manage-identity-providers', 'clin', '8271513b-5e8c-4b3b-9374-5c477d2010a0', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('a925a7eb-8e76-4f09-876f-b84ba2cc14ff', '8271513b-5e8c-4b3b-9374-5c477d2010a0', true, '${role_manage-authorization}', 'manage-authorization', 'clin', '8271513b-5e8c-4b3b-9374-5c477d2010a0', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('221a675a-0348-4e08-a33c-f618fc0daa06', '8271513b-5e8c-4b3b-9374-5c477d2010a0', true, '${role_query-users}', 'query-users', 'clin', '8271513b-5e8c-4b3b-9374-5c477d2010a0', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('d26865dc-7317-4203-9dfa-10d670c6a966', '8271513b-5e8c-4b3b-9374-5c477d2010a0', true, '${role_query-clients}', 'query-clients', 'clin', '8271513b-5e8c-4b3b-9374-5c477d2010a0', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('721590b3-0df3-4e41-874c-d640496d879c', '8271513b-5e8c-4b3b-9374-5c477d2010a0', true, '${role_query-realms}', 'query-realms', 'clin', '8271513b-5e8c-4b3b-9374-5c477d2010a0', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('f40f04f7-163a-49b9-a11d-686cb797b906', '8271513b-5e8c-4b3b-9374-5c477d2010a0', true, '${role_query-groups}', 'query-groups', 'clin', '8271513b-5e8c-4b3b-9374-5c477d2010a0', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('8225db5a-8cb6-4040-ad0d-337d689207da', 'f7af93f2-37c5-4cf6-b07e-7b6620cf8458', true, '${role_view-profile}', 'view-profile', 'clin', 'f7af93f2-37c5-4cf6-b07e-7b6620cf8458', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('43d9eeda-d8c0-46e2-bc15-1b7049bd3824', 'f7af93f2-37c5-4cf6-b07e-7b6620cf8458', true, '${role_manage-account}', 'manage-account', 'clin', 'f7af93f2-37c5-4cf6-b07e-7b6620cf8458', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('173e686b-0671-4751-acd7-b7f0784624ee', 'f7af93f2-37c5-4cf6-b07e-7b6620cf8458', true, '${role_manage-account-links}', 'manage-account-links', 'clin', 'f7af93f2-37c5-4cf6-b07e-7b6620cf8458', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('287fe93c-5a98-43ce-a47a-be3607217fe8', 'f7af93f2-37c5-4cf6-b07e-7b6620cf8458', true, '${role_view-applications}', 'view-applications', 'clin', 'f7af93f2-37c5-4cf6-b07e-7b6620cf8458', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('a8635269-aa56-407e-bd36-a7f94e824fad', 'f7af93f2-37c5-4cf6-b07e-7b6620cf8458', true, '${role_view-consent}', 'view-consent', 'clin', 'f7af93f2-37c5-4cf6-b07e-7b6620cf8458', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('1539b57d-aa2f-4c67-8ff6-1c08047deb92', 'f7af93f2-37c5-4cf6-b07e-7b6620cf8458', true, '${role_manage-consent}', 'manage-consent', 'clin', 'f7af93f2-37c5-4cf6-b07e-7b6620cf8458', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('f052c566-3560-41ca-94b0-4d8621e4863c', 'f7af93f2-37c5-4cf6-b07e-7b6620cf8458', true, '${role_delete-account}', 'delete-account', 'clin', 'f7af93f2-37c5-4cf6-b07e-7b6620cf8458', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('03425469-0e84-48c3-ab00-fef0d2b3c957', '4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', true, '${role_impersonation}', 'impersonation', 'master', '4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('b518f283-f92f-4c4c-8dd1-a813a4db1c28', '8271513b-5e8c-4b3b-9374-5c477d2010a0', true, '${role_impersonation}', 'impersonation', 'clin', '8271513b-5e8c-4b3b-9374-5c477d2010a0', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('6a57fd7f-cadf-4372-838f-a5fd95da9863', '5d0fab1b-4e20-4c5a-b1bd-017bedd9e3e4', true, '${role_read-token}', 'read-token', 'clin', '5d0fab1b-4e20-4c5a-b1bd-017bedd9e3e4', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('b9688af1-84bc-4bbf-892d-5732be692351', 'clin', false, '${role_offline-access}', 'offline_access', 'clin', NULL, 'clin');
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('eb2d2063-6c44-4ae8-bf9f-081a073e19fd', 'clin', false, '${role_uma_authorization}', 'uma_authorization', 'clin', NULL, 'clin');
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('56203064-25da-4fb1-8a34-ff41d538d28a', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', true, NULL, 'uma_protection', 'clin', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('8604cce2-1de7-4326-950f-9473751b9b95', 'clin', false, NULL, 'clin_prescriber', 'clin', NULL, 'clin');
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('2ee5ec6b-46da-4988-9967-949a327f5ffd', 'clin', false, NULL, 'clin_genetician', 'clin', NULL, 'clin');
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('c7b0ab20-de04-4e5c-a127-ac4aa8c97bf4', 'clin', false, NULL, 'clin_administrator', 'clin', NULL, 'clin');


--
-- TOC entry 4188 (class 0 OID 16614)
-- Dependencies: 262
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.migration_model (id, version, update_time) VALUES ('1dcjo', '12.0.3', 1683126062);


--
-- TOC entry 4189 (class 0 OID 16618)
-- Dependencies: 263
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4190 (class 0 OID 16625)
-- Dependencies: 264
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4191 (class 0 OID 16631)
-- Dependencies: 265
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.policy_config (policy_id, name, value) VALUES ('09932e6c-5f26-4322-b346-83e6282bd81a', 'code', '// by default, grants any permission associated with this policy
$evaluation.grant();
');
INSERT INTO public.policy_config (policy_id, name, value) VALUES ('564f17f2-b764-4205-b51a-11c0505cfa37', 'defaultResourceType', 'urn:clin-acl:resources:default');
INSERT INTO public.policy_config (policy_id, name, value) VALUES ('5ed10474-21bf-40e9-bbb3-f80eab73baaa', 'clients', '["8f553005-b544-4e27-8fbc-a9a517ed6fe9"]');
INSERT INTO public.policy_config (policy_id, name, value) VALUES ('de9e7111-fc7c-4e3c-9462-40c25d524f94', 'roles', '[{"id":"8604cce2-1de7-4326-950f-9473751b9b95","required":true}]');
INSERT INTO public.policy_config (policy_id, name, value) VALUES ('f9b6ce0f-635b-4ba0-961b-39f98ba3fb6b', 'roles', '[{"id":"2ee5ec6b-46da-4988-9967-949a327f5ffd","required":true}]');
INSERT INTO public.policy_config (policy_id, name, value) VALUES ('29b6112f-abdc-407c-888f-37915d530d29', 'roles', '[{"id":"c7b0ab20-de04-4e5c-a127-ac4aa8c97bf4","required":true}]');


--
-- TOC entry 4192 (class 0 OID 16636)
-- Dependencies: 266
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('f0256d1d-730d-45d4-94b8-52da84630310', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', '0fc80003-6ce5-46c2-a047-1d0e44291402', NULL);
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('36943620-35c1-4d58-a5a0-1ed58065454d', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', '21967484-d12e-48b0-8a2d-acc885559c01', NULL);
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('862ab02c-066c-43a3-9c82-809951269d05', 'role list', 'saml', 'saml-role-list-mapper', NULL, '86ff35aa-e6a2-4eae-85e6-cbe8861a9c2e');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('b9558786-3dee-442f-9c91-f8701d6d5ab0', 'full name', 'openid-connect', 'oidc-full-name-mapper', NULL, 'f141d59d-1c7a-49d8-a3ce-566db1a2d612');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('ca03bc0c-ad56-463a-8b5c-5e44528126a4', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, 'f141d59d-1c7a-49d8-a3ce-566db1a2d612');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('40f517a5-c505-4d8d-a939-20776ed8feab', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, 'f141d59d-1c7a-49d8-a3ce-566db1a2d612');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('0718b6f0-8b05-4a9b-97a3-e2483b291c3d', 'middle name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'f141d59d-1c7a-49d8-a3ce-566db1a2d612');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('9d65d159-41cc-4960-b40a-7c335fd02c92', 'nickname', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'f141d59d-1c7a-49d8-a3ce-566db1a2d612');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('5ad945b3-b68b-4270-b52e-615c78ecfd3d', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, 'f141d59d-1c7a-49d8-a3ce-566db1a2d612');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('22b04039-1094-41d2-9cd5-28ebf3b8dfdc', 'profile', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'f141d59d-1c7a-49d8-a3ce-566db1a2d612');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('d3911c5d-60ae-47ae-9047-a611e81e3738', 'picture', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'f141d59d-1c7a-49d8-a3ce-566db1a2d612');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('cf235674-a27a-49fe-a752-18419401180f', 'website', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'f141d59d-1c7a-49d8-a3ce-566db1a2d612');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('3e0ee0df-adb7-4521-925a-6254e5e13f6c', 'gender', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'f141d59d-1c7a-49d8-a3ce-566db1a2d612');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('b456b527-48bd-4733-ab03-5a76d3434026', 'birthdate', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'f141d59d-1c7a-49d8-a3ce-566db1a2d612');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('f10b3817-a830-47bd-82b9-f8903cf81e06', 'zoneinfo', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'f141d59d-1c7a-49d8-a3ce-566db1a2d612');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('dcf0cb23-906d-454d-bc7b-1effdc0b87b4', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'f141d59d-1c7a-49d8-a3ce-566db1a2d612');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('22f5a522-1d1b-4cb9-bec2-10c01055451d', 'updated at', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'f141d59d-1c7a-49d8-a3ce-566db1a2d612');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('13c863c0-de2e-4036-8a30-16485a3f28aa', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '50d34770-cf89-4dd0-90c3-81f216bcb84f');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('1d124caf-9ff3-4553-b20e-1b816eae79de', 'email verified', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '50d34770-cf89-4dd0-90c3-81f216bcb84f');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('142cc6e0-d62c-4a17-8847-a9536e03d192', 'address', 'openid-connect', 'oidc-address-mapper', NULL, '3d130846-07fd-49e3-8977-58ce8f3db9ca');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('aadeecc4-c1c5-4e77-81c2-5b3122d2515e', 'phone number', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '2fd3e2bf-b67f-498d-97f9-7ec9b2cd01ae');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('d9113b6d-817b-4b6f-a05a-49328ef601a6', 'phone number verified', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '2fd3e2bf-b67f-498d-97f9-7ec9b2cd01ae');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('0ea3ac9a-ac91-4e30-922f-155d305b04c4', 'realm roles', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, '4f187629-96c5-4696-9817-e23d18019241');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('3ea92166-e9ac-4c32-a79d-30c47273b28a', 'client roles', 'openid-connect', 'oidc-usermodel-client-role-mapper', NULL, '4f187629-96c5-4696-9817-e23d18019241');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('2876b927-947e-4576-b746-4b28dabf3849', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', NULL, '4f187629-96c5-4696-9817-e23d18019241');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('fa32147d-09c9-45f9-a6b8-60956a6a4f84', 'allowed web origins', 'openid-connect', 'oidc-allowed-origins-mapper', NULL, '8f3eca4b-2621-407b-8499-4e00b57caae8');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('4faf2da6-0226-4226-bb45-f2c78c019dc0', 'upn', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '6747b15d-6950-4e9e-992a-fce71215ad12');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('5acb41b1-69c3-46cc-b12f-730604bdc432', 'groups', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, '6747b15d-6950-4e9e-992a-fce71215ad12');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('89e5a57e-c9e4-4739-a099-70fb1624298c', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', '09e07cd8-2e94-4ce2-acbe-981d5d672371', NULL);
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('8f622cc7-7461-4999-beba-d7ea083b52da', 'role list', 'saml', 'saml-role-list-mapper', NULL, '1bc050b5-b982-4107-8b55-3500654c5426');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('a56d5c07-8f8a-470b-b0f4-101be926ab9e', 'full name', 'openid-connect', 'oidc-full-name-mapper', NULL, 'ff25c7ed-164d-4556-85d9-193193c025ca');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('da86310b-07f5-476c-bbd4-d216fdd8836f', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, 'ff25c7ed-164d-4556-85d9-193193c025ca');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('be0423ac-aaa6-496b-9ca1-8b718e18c8f3', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, 'ff25c7ed-164d-4556-85d9-193193c025ca');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('f27017b1-7e3f-44cc-887a-7c2cd6b5817a', 'middle name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'ff25c7ed-164d-4556-85d9-193193c025ca');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('497eba89-a9d0-4643-9fc7-bbdcdff86adf', 'nickname', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'ff25c7ed-164d-4556-85d9-193193c025ca');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('c8e053a3-493b-41bd-af81-601237125545', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, 'ff25c7ed-164d-4556-85d9-193193c025ca');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('23a79605-430f-46b3-a685-d59f8bdf0f6e', 'profile', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'ff25c7ed-164d-4556-85d9-193193c025ca');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('7a160dd6-3ce9-4bcd-8136-f10618527837', 'picture', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'ff25c7ed-164d-4556-85d9-193193c025ca');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('340e5d44-f5bd-4336-b3b8-f1e2a6b2f205', 'website', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'ff25c7ed-164d-4556-85d9-193193c025ca');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('8a0424a9-cc83-47d3-a491-716f2b237098', 'gender', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'ff25c7ed-164d-4556-85d9-193193c025ca');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('42543e3c-39d8-4112-9acb-68ac2584240c', 'birthdate', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'ff25c7ed-164d-4556-85d9-193193c025ca');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('97b1351b-3577-497d-9d7e-2318a46994e8', 'zoneinfo', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'ff25c7ed-164d-4556-85d9-193193c025ca');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('c0bf074e-1231-46db-a12c-1a7bf14f0d4e', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'ff25c7ed-164d-4556-85d9-193193c025ca');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('0ecf936d-ece4-43d3-aea3-e9f4d8e4f5a1', 'updated at', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'ff25c7ed-164d-4556-85d9-193193c025ca');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('5c0b9625-71f9-47e8-8b06-802d292cc7ee', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '85f5d4de-1159-4385-b47a-2624724fb2cf');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('4433df3c-ebde-48dd-ab18-0621e2dcf612', 'email verified', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '85f5d4de-1159-4385-b47a-2624724fb2cf');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('06c09ff5-0997-4608-aac5-efc48331c978', 'address', 'openid-connect', 'oidc-address-mapper', NULL, '72f04a91-426c-4691-bddb-58ced7f53b0a');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('eb66e54d-6021-4dce-bfee-87bd36f89449', 'phone number', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '614d16e8-4c8f-4a48-a1d1-91d0bf237195');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('f49bfd28-b0eb-4218-9bdb-ed26a5e336c1', 'phone number verified', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '614d16e8-4c8f-4a48-a1d1-91d0bf237195');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('3544e140-6e0d-4cb8-b37d-cef759c6a810', 'realm roles', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, 'fd7a4932-739c-46c2-93d3-c43e3d3b4a22');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('6114ff2a-95fc-49e0-8db3-0278bf4b4773', 'client roles', 'openid-connect', 'oidc-usermodel-client-role-mapper', NULL, 'fd7a4932-739c-46c2-93d3-c43e3d3b4a22');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('f74b1f33-3475-40bf-b215-0413258ce5ec', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', NULL, 'fd7a4932-739c-46c2-93d3-c43e3d3b4a22');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('4daa2fca-88d9-447b-8550-0e0ac701d4de', 'allowed web origins', 'openid-connect', 'oidc-allowed-origins-mapper', NULL, '5469a308-5768-474c-9ab6-39e98a21b841');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('43a397a3-a545-474d-ba94-ada4e7268da5', 'upn', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '11938e7f-466f-4e38-8e1b-dcd01f70a0fd');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('ce861e0d-00a0-4620-966e-d6c4e76d0264', 'groups', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, '11938e7f-466f-4e38-8e1b-dcd01f70a0fd');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('767332f9-0724-442b-bc1c-6707a415ee10', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', '78e8963c-3ea0-4eee-b438-237191ebab68', NULL);
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('c4128530-3c65-4b95-a199-14b11ad0f0ee', 'Client ID', 'openid-connect', 'oidc-usersessionmodel-note-mapper', '8f553005-b544-4e27-8fbc-a9a517ed6fe9', NULL);
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('3355cb42-fed4-4bdd-b8dc-f800634befbd', 'Client Host', 'openid-connect', 'oidc-usersessionmodel-note-mapper', '8f553005-b544-4e27-8fbc-a9a517ed6fe9', NULL);
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('2fdecedd-345a-4bb0-bf62-b0b91d2f3c06', 'Client IP Address', 'openid-connect', 'oidc-usersessionmodel-note-mapper', '8f553005-b544-4e27-8fbc-a9a517ed6fe9', NULL);
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('7ee2ac87-7941-4a64-bc52-30aefc2d9d09', 'Client ID', 'openid-connect', 'oidc-usersessionmodel-note-mapper', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', NULL);
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('f0c52aa6-c988-4419-98ed-8f86e668a0f4', 'Client Host', 'openid-connect', 'oidc-usersessionmodel-note-mapper', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', NULL);
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('0bf49369-d78e-4049-a5fc-99880e526c71', 'Client IP Address', 'openid-connect', 'oidc-usersessionmodel-note-mapper', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', NULL);
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('99e79a67-2cb2-40a9-b347-0f8208184742', 'fhir_practitioner_id', 'openid-connect', 'oidc-usermodel-attribute-mapper', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', NULL);
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('864811fb-0414-4157-a531-e1198dedc02f', 'fhir_organization_id', 'openid-connect', 'oidc-usermodel-attribute-mapper', 'df77c1aa-6543-489f-919a-3880f58d5494', NULL);
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('bfb9cdb6-76db-4532-b8b5-29cb9c291e9a', 'fhir_practitioner_id', 'openid-connect', 'oidc-usermodel-attribute-mapper', 'df77c1aa-6543-489f-919a-3880f58d5494', NULL);
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('b5e21891-a97b-406d-b789-f5f85b3dd8bd', 'fhir_organization_id', 'openid-connect', 'oidc-usermodel-attribute-mapper', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', NULL);


--
-- TOC entry 4193 (class 0 OID 16641)
-- Dependencies: 267
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('36943620-35c1-4d58-a5a0-1ed58065454d', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('36943620-35c1-4d58-a5a0-1ed58065454d', 'locale', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('36943620-35c1-4d58-a5a0-1ed58065454d', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('36943620-35c1-4d58-a5a0-1ed58065454d', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('36943620-35c1-4d58-a5a0-1ed58065454d', 'locale', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('36943620-35c1-4d58-a5a0-1ed58065454d', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('862ab02c-066c-43a3-9c82-809951269d05', 'false', 'single');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('862ab02c-066c-43a3-9c82-809951269d05', 'Basic', 'attribute.nameformat');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('862ab02c-066c-43a3-9c82-809951269d05', 'Role', 'attribute.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b9558786-3dee-442f-9c91-f8701d6d5ab0', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b9558786-3dee-442f-9c91-f8701d6d5ab0', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b9558786-3dee-442f-9c91-f8701d6d5ab0', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('ca03bc0c-ad56-463a-8b5c-5e44528126a4', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('ca03bc0c-ad56-463a-8b5c-5e44528126a4', 'lastName', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('ca03bc0c-ad56-463a-8b5c-5e44528126a4', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('ca03bc0c-ad56-463a-8b5c-5e44528126a4', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('ca03bc0c-ad56-463a-8b5c-5e44528126a4', 'family_name', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('ca03bc0c-ad56-463a-8b5c-5e44528126a4', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('40f517a5-c505-4d8d-a939-20776ed8feab', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('40f517a5-c505-4d8d-a939-20776ed8feab', 'firstName', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('40f517a5-c505-4d8d-a939-20776ed8feab', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('40f517a5-c505-4d8d-a939-20776ed8feab', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('40f517a5-c505-4d8d-a939-20776ed8feab', 'given_name', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('40f517a5-c505-4d8d-a939-20776ed8feab', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0718b6f0-8b05-4a9b-97a3-e2483b291c3d', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0718b6f0-8b05-4a9b-97a3-e2483b291c3d', 'middleName', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0718b6f0-8b05-4a9b-97a3-e2483b291c3d', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0718b6f0-8b05-4a9b-97a3-e2483b291c3d', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0718b6f0-8b05-4a9b-97a3-e2483b291c3d', 'middle_name', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0718b6f0-8b05-4a9b-97a3-e2483b291c3d', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9d65d159-41cc-4960-b40a-7c335fd02c92', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9d65d159-41cc-4960-b40a-7c335fd02c92', 'nickname', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9d65d159-41cc-4960-b40a-7c335fd02c92', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9d65d159-41cc-4960-b40a-7c335fd02c92', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9d65d159-41cc-4960-b40a-7c335fd02c92', 'nickname', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9d65d159-41cc-4960-b40a-7c335fd02c92', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5ad945b3-b68b-4270-b52e-615c78ecfd3d', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5ad945b3-b68b-4270-b52e-615c78ecfd3d', 'username', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5ad945b3-b68b-4270-b52e-615c78ecfd3d', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5ad945b3-b68b-4270-b52e-615c78ecfd3d', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5ad945b3-b68b-4270-b52e-615c78ecfd3d', 'preferred_username', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5ad945b3-b68b-4270-b52e-615c78ecfd3d', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('22b04039-1094-41d2-9cd5-28ebf3b8dfdc', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('22b04039-1094-41d2-9cd5-28ebf3b8dfdc', 'profile', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('22b04039-1094-41d2-9cd5-28ebf3b8dfdc', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('22b04039-1094-41d2-9cd5-28ebf3b8dfdc', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('22b04039-1094-41d2-9cd5-28ebf3b8dfdc', 'profile', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('22b04039-1094-41d2-9cd5-28ebf3b8dfdc', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('d3911c5d-60ae-47ae-9047-a611e81e3738', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('d3911c5d-60ae-47ae-9047-a611e81e3738', 'picture', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('d3911c5d-60ae-47ae-9047-a611e81e3738', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('d3911c5d-60ae-47ae-9047-a611e81e3738', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('d3911c5d-60ae-47ae-9047-a611e81e3738', 'picture', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('d3911c5d-60ae-47ae-9047-a611e81e3738', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('cf235674-a27a-49fe-a752-18419401180f', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('cf235674-a27a-49fe-a752-18419401180f', 'website', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('cf235674-a27a-49fe-a752-18419401180f', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('cf235674-a27a-49fe-a752-18419401180f', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('cf235674-a27a-49fe-a752-18419401180f', 'website', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('cf235674-a27a-49fe-a752-18419401180f', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3e0ee0df-adb7-4521-925a-6254e5e13f6c', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3e0ee0df-adb7-4521-925a-6254e5e13f6c', 'gender', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3e0ee0df-adb7-4521-925a-6254e5e13f6c', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3e0ee0df-adb7-4521-925a-6254e5e13f6c', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3e0ee0df-adb7-4521-925a-6254e5e13f6c', 'gender', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3e0ee0df-adb7-4521-925a-6254e5e13f6c', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b456b527-48bd-4733-ab03-5a76d3434026', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b456b527-48bd-4733-ab03-5a76d3434026', 'birthdate', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b456b527-48bd-4733-ab03-5a76d3434026', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b456b527-48bd-4733-ab03-5a76d3434026', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b456b527-48bd-4733-ab03-5a76d3434026', 'birthdate', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b456b527-48bd-4733-ab03-5a76d3434026', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f10b3817-a830-47bd-82b9-f8903cf81e06', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f10b3817-a830-47bd-82b9-f8903cf81e06', 'zoneinfo', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f10b3817-a830-47bd-82b9-f8903cf81e06', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f10b3817-a830-47bd-82b9-f8903cf81e06', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f10b3817-a830-47bd-82b9-f8903cf81e06', 'zoneinfo', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f10b3817-a830-47bd-82b9-f8903cf81e06', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('dcf0cb23-906d-454d-bc7b-1effdc0b87b4', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('dcf0cb23-906d-454d-bc7b-1effdc0b87b4', 'locale', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('dcf0cb23-906d-454d-bc7b-1effdc0b87b4', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('dcf0cb23-906d-454d-bc7b-1effdc0b87b4', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('dcf0cb23-906d-454d-bc7b-1effdc0b87b4', 'locale', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('dcf0cb23-906d-454d-bc7b-1effdc0b87b4', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('22f5a522-1d1b-4cb9-bec2-10c01055451d', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('22f5a522-1d1b-4cb9-bec2-10c01055451d', 'updatedAt', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('22f5a522-1d1b-4cb9-bec2-10c01055451d', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('22f5a522-1d1b-4cb9-bec2-10c01055451d', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('22f5a522-1d1b-4cb9-bec2-10c01055451d', 'updated_at', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('22f5a522-1d1b-4cb9-bec2-10c01055451d', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('13c863c0-de2e-4036-8a30-16485a3f28aa', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('13c863c0-de2e-4036-8a30-16485a3f28aa', 'email', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('13c863c0-de2e-4036-8a30-16485a3f28aa', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('13c863c0-de2e-4036-8a30-16485a3f28aa', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('13c863c0-de2e-4036-8a30-16485a3f28aa', 'email', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('13c863c0-de2e-4036-8a30-16485a3f28aa', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('1d124caf-9ff3-4553-b20e-1b816eae79de', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('1d124caf-9ff3-4553-b20e-1b816eae79de', 'emailVerified', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('1d124caf-9ff3-4553-b20e-1b816eae79de', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('1d124caf-9ff3-4553-b20e-1b816eae79de', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('1d124caf-9ff3-4553-b20e-1b816eae79de', 'email_verified', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('1d124caf-9ff3-4553-b20e-1b816eae79de', 'boolean', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('142cc6e0-d62c-4a17-8847-a9536e03d192', 'formatted', 'user.attribute.formatted');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('142cc6e0-d62c-4a17-8847-a9536e03d192', 'country', 'user.attribute.country');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('142cc6e0-d62c-4a17-8847-a9536e03d192', 'postal_code', 'user.attribute.postal_code');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('142cc6e0-d62c-4a17-8847-a9536e03d192', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('142cc6e0-d62c-4a17-8847-a9536e03d192', 'street', 'user.attribute.street');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('142cc6e0-d62c-4a17-8847-a9536e03d192', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('142cc6e0-d62c-4a17-8847-a9536e03d192', 'region', 'user.attribute.region');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('142cc6e0-d62c-4a17-8847-a9536e03d192', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('142cc6e0-d62c-4a17-8847-a9536e03d192', 'locality', 'user.attribute.locality');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('aadeecc4-c1c5-4e77-81c2-5b3122d2515e', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('aadeecc4-c1c5-4e77-81c2-5b3122d2515e', 'phoneNumber', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('aadeecc4-c1c5-4e77-81c2-5b3122d2515e', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('aadeecc4-c1c5-4e77-81c2-5b3122d2515e', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('aadeecc4-c1c5-4e77-81c2-5b3122d2515e', 'phone_number', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('aadeecc4-c1c5-4e77-81c2-5b3122d2515e', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('d9113b6d-817b-4b6f-a05a-49328ef601a6', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('d9113b6d-817b-4b6f-a05a-49328ef601a6', 'phoneNumberVerified', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('d9113b6d-817b-4b6f-a05a-49328ef601a6', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('d9113b6d-817b-4b6f-a05a-49328ef601a6', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('d9113b6d-817b-4b6f-a05a-49328ef601a6', 'phone_number_verified', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('d9113b6d-817b-4b6f-a05a-49328ef601a6', 'boolean', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0ea3ac9a-ac91-4e30-922f-155d305b04c4', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0ea3ac9a-ac91-4e30-922f-155d305b04c4', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0ea3ac9a-ac91-4e30-922f-155d305b04c4', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0ea3ac9a-ac91-4e30-922f-155d305b04c4', 'realm_access.roles', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0ea3ac9a-ac91-4e30-922f-155d305b04c4', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3ea92166-e9ac-4c32-a79d-30c47273b28a', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3ea92166-e9ac-4c32-a79d-30c47273b28a', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3ea92166-e9ac-4c32-a79d-30c47273b28a', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3ea92166-e9ac-4c32-a79d-30c47273b28a', 'resource_access.${client_id}.roles', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3ea92166-e9ac-4c32-a79d-30c47273b28a', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4faf2da6-0226-4226-bb45-f2c78c019dc0', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4faf2da6-0226-4226-bb45-f2c78c019dc0', 'username', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4faf2da6-0226-4226-bb45-f2c78c019dc0', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4faf2da6-0226-4226-bb45-f2c78c019dc0', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4faf2da6-0226-4226-bb45-f2c78c019dc0', 'upn', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4faf2da6-0226-4226-bb45-f2c78c019dc0', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5acb41b1-69c3-46cc-b12f-730604bdc432', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5acb41b1-69c3-46cc-b12f-730604bdc432', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5acb41b1-69c3-46cc-b12f-730604bdc432', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5acb41b1-69c3-46cc-b12f-730604bdc432', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5acb41b1-69c3-46cc-b12f-730604bdc432', 'groups', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5acb41b1-69c3-46cc-b12f-730604bdc432', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8f622cc7-7461-4999-beba-d7ea083b52da', 'false', 'single');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8f622cc7-7461-4999-beba-d7ea083b52da', 'Basic', 'attribute.nameformat');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8f622cc7-7461-4999-beba-d7ea083b52da', 'Role', 'attribute.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a56d5c07-8f8a-470b-b0f4-101be926ab9e', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a56d5c07-8f8a-470b-b0f4-101be926ab9e', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a56d5c07-8f8a-470b-b0f4-101be926ab9e', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('da86310b-07f5-476c-bbd4-d216fdd8836f', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('da86310b-07f5-476c-bbd4-d216fdd8836f', 'lastName', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('da86310b-07f5-476c-bbd4-d216fdd8836f', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('da86310b-07f5-476c-bbd4-d216fdd8836f', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('da86310b-07f5-476c-bbd4-d216fdd8836f', 'family_name', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('da86310b-07f5-476c-bbd4-d216fdd8836f', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('be0423ac-aaa6-496b-9ca1-8b718e18c8f3', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('be0423ac-aaa6-496b-9ca1-8b718e18c8f3', 'firstName', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('be0423ac-aaa6-496b-9ca1-8b718e18c8f3', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('be0423ac-aaa6-496b-9ca1-8b718e18c8f3', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('be0423ac-aaa6-496b-9ca1-8b718e18c8f3', 'given_name', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('be0423ac-aaa6-496b-9ca1-8b718e18c8f3', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f27017b1-7e3f-44cc-887a-7c2cd6b5817a', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f27017b1-7e3f-44cc-887a-7c2cd6b5817a', 'middleName', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f27017b1-7e3f-44cc-887a-7c2cd6b5817a', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f27017b1-7e3f-44cc-887a-7c2cd6b5817a', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f27017b1-7e3f-44cc-887a-7c2cd6b5817a', 'middle_name', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f27017b1-7e3f-44cc-887a-7c2cd6b5817a', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('497eba89-a9d0-4643-9fc7-bbdcdff86adf', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('497eba89-a9d0-4643-9fc7-bbdcdff86adf', 'nickname', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('497eba89-a9d0-4643-9fc7-bbdcdff86adf', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('497eba89-a9d0-4643-9fc7-bbdcdff86adf', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('497eba89-a9d0-4643-9fc7-bbdcdff86adf', 'nickname', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('497eba89-a9d0-4643-9fc7-bbdcdff86adf', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c8e053a3-493b-41bd-af81-601237125545', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c8e053a3-493b-41bd-af81-601237125545', 'username', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c8e053a3-493b-41bd-af81-601237125545', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c8e053a3-493b-41bd-af81-601237125545', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c8e053a3-493b-41bd-af81-601237125545', 'preferred_username', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c8e053a3-493b-41bd-af81-601237125545', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('23a79605-430f-46b3-a685-d59f8bdf0f6e', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('23a79605-430f-46b3-a685-d59f8bdf0f6e', 'profile', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('23a79605-430f-46b3-a685-d59f8bdf0f6e', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('23a79605-430f-46b3-a685-d59f8bdf0f6e', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('23a79605-430f-46b3-a685-d59f8bdf0f6e', 'profile', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('23a79605-430f-46b3-a685-d59f8bdf0f6e', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7a160dd6-3ce9-4bcd-8136-f10618527837', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7a160dd6-3ce9-4bcd-8136-f10618527837', 'picture', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7a160dd6-3ce9-4bcd-8136-f10618527837', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7a160dd6-3ce9-4bcd-8136-f10618527837', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7a160dd6-3ce9-4bcd-8136-f10618527837', 'picture', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7a160dd6-3ce9-4bcd-8136-f10618527837', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('340e5d44-f5bd-4336-b3b8-f1e2a6b2f205', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('340e5d44-f5bd-4336-b3b8-f1e2a6b2f205', 'website', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('340e5d44-f5bd-4336-b3b8-f1e2a6b2f205', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('340e5d44-f5bd-4336-b3b8-f1e2a6b2f205', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('340e5d44-f5bd-4336-b3b8-f1e2a6b2f205', 'website', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('340e5d44-f5bd-4336-b3b8-f1e2a6b2f205', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8a0424a9-cc83-47d3-a491-716f2b237098', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8a0424a9-cc83-47d3-a491-716f2b237098', 'gender', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8a0424a9-cc83-47d3-a491-716f2b237098', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8a0424a9-cc83-47d3-a491-716f2b237098', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8a0424a9-cc83-47d3-a491-716f2b237098', 'gender', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8a0424a9-cc83-47d3-a491-716f2b237098', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('42543e3c-39d8-4112-9acb-68ac2584240c', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('42543e3c-39d8-4112-9acb-68ac2584240c', 'birthdate', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('42543e3c-39d8-4112-9acb-68ac2584240c', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('42543e3c-39d8-4112-9acb-68ac2584240c', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('42543e3c-39d8-4112-9acb-68ac2584240c', 'birthdate', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('42543e3c-39d8-4112-9acb-68ac2584240c', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('97b1351b-3577-497d-9d7e-2318a46994e8', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('97b1351b-3577-497d-9d7e-2318a46994e8', 'zoneinfo', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('97b1351b-3577-497d-9d7e-2318a46994e8', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('97b1351b-3577-497d-9d7e-2318a46994e8', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('97b1351b-3577-497d-9d7e-2318a46994e8', 'zoneinfo', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('97b1351b-3577-497d-9d7e-2318a46994e8', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c0bf074e-1231-46db-a12c-1a7bf14f0d4e', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c0bf074e-1231-46db-a12c-1a7bf14f0d4e', 'locale', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c0bf074e-1231-46db-a12c-1a7bf14f0d4e', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c0bf074e-1231-46db-a12c-1a7bf14f0d4e', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c0bf074e-1231-46db-a12c-1a7bf14f0d4e', 'locale', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c0bf074e-1231-46db-a12c-1a7bf14f0d4e', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0ecf936d-ece4-43d3-aea3-e9f4d8e4f5a1', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0ecf936d-ece4-43d3-aea3-e9f4d8e4f5a1', 'updatedAt', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0ecf936d-ece4-43d3-aea3-e9f4d8e4f5a1', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0ecf936d-ece4-43d3-aea3-e9f4d8e4f5a1', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0ecf936d-ece4-43d3-aea3-e9f4d8e4f5a1', 'updated_at', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0ecf936d-ece4-43d3-aea3-e9f4d8e4f5a1', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5c0b9625-71f9-47e8-8b06-802d292cc7ee', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5c0b9625-71f9-47e8-8b06-802d292cc7ee', 'email', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5c0b9625-71f9-47e8-8b06-802d292cc7ee', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5c0b9625-71f9-47e8-8b06-802d292cc7ee', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5c0b9625-71f9-47e8-8b06-802d292cc7ee', 'email', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5c0b9625-71f9-47e8-8b06-802d292cc7ee', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4433df3c-ebde-48dd-ab18-0621e2dcf612', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4433df3c-ebde-48dd-ab18-0621e2dcf612', 'emailVerified', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4433df3c-ebde-48dd-ab18-0621e2dcf612', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4433df3c-ebde-48dd-ab18-0621e2dcf612', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4433df3c-ebde-48dd-ab18-0621e2dcf612', 'email_verified', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4433df3c-ebde-48dd-ab18-0621e2dcf612', 'boolean', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('06c09ff5-0997-4608-aac5-efc48331c978', 'formatted', 'user.attribute.formatted');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('06c09ff5-0997-4608-aac5-efc48331c978', 'country', 'user.attribute.country');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('06c09ff5-0997-4608-aac5-efc48331c978', 'postal_code', 'user.attribute.postal_code');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('06c09ff5-0997-4608-aac5-efc48331c978', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('06c09ff5-0997-4608-aac5-efc48331c978', 'street', 'user.attribute.street');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('06c09ff5-0997-4608-aac5-efc48331c978', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('06c09ff5-0997-4608-aac5-efc48331c978', 'region', 'user.attribute.region');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('06c09ff5-0997-4608-aac5-efc48331c978', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('06c09ff5-0997-4608-aac5-efc48331c978', 'locality', 'user.attribute.locality');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('eb66e54d-6021-4dce-bfee-87bd36f89449', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('eb66e54d-6021-4dce-bfee-87bd36f89449', 'phoneNumber', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('eb66e54d-6021-4dce-bfee-87bd36f89449', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('eb66e54d-6021-4dce-bfee-87bd36f89449', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('eb66e54d-6021-4dce-bfee-87bd36f89449', 'phone_number', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('eb66e54d-6021-4dce-bfee-87bd36f89449', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f49bfd28-b0eb-4218-9bdb-ed26a5e336c1', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f49bfd28-b0eb-4218-9bdb-ed26a5e336c1', 'phoneNumberVerified', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f49bfd28-b0eb-4218-9bdb-ed26a5e336c1', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f49bfd28-b0eb-4218-9bdb-ed26a5e336c1', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f49bfd28-b0eb-4218-9bdb-ed26a5e336c1', 'phone_number_verified', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f49bfd28-b0eb-4218-9bdb-ed26a5e336c1', 'boolean', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3544e140-6e0d-4cb8-b37d-cef759c6a810', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3544e140-6e0d-4cb8-b37d-cef759c6a810', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3544e140-6e0d-4cb8-b37d-cef759c6a810', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3544e140-6e0d-4cb8-b37d-cef759c6a810', 'realm_access.roles', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3544e140-6e0d-4cb8-b37d-cef759c6a810', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('6114ff2a-95fc-49e0-8db3-0278bf4b4773', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('6114ff2a-95fc-49e0-8db3-0278bf4b4773', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('6114ff2a-95fc-49e0-8db3-0278bf4b4773', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('6114ff2a-95fc-49e0-8db3-0278bf4b4773', 'resource_access.${client_id}.roles', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('6114ff2a-95fc-49e0-8db3-0278bf4b4773', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('43a397a3-a545-474d-ba94-ada4e7268da5', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('43a397a3-a545-474d-ba94-ada4e7268da5', 'username', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('43a397a3-a545-474d-ba94-ada4e7268da5', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('43a397a3-a545-474d-ba94-ada4e7268da5', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('43a397a3-a545-474d-ba94-ada4e7268da5', 'upn', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('43a397a3-a545-474d-ba94-ada4e7268da5', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('ce861e0d-00a0-4620-966e-d6c4e76d0264', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('ce861e0d-00a0-4620-966e-d6c4e76d0264', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('ce861e0d-00a0-4620-966e-d6c4e76d0264', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('ce861e0d-00a0-4620-966e-d6c4e76d0264', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('ce861e0d-00a0-4620-966e-d6c4e76d0264', 'groups', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('ce861e0d-00a0-4620-966e-d6c4e76d0264', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('767332f9-0724-442b-bc1c-6707a415ee10', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('767332f9-0724-442b-bc1c-6707a415ee10', 'locale', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('767332f9-0724-442b-bc1c-6707a415ee10', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('767332f9-0724-442b-bc1c-6707a415ee10', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('767332f9-0724-442b-bc1c-6707a415ee10', 'locale', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('767332f9-0724-442b-bc1c-6707a415ee10', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c4128530-3c65-4b95-a199-14b11ad0f0ee', 'clientId', 'user.session.note');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c4128530-3c65-4b95-a199-14b11ad0f0ee', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c4128530-3c65-4b95-a199-14b11ad0f0ee', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c4128530-3c65-4b95-a199-14b11ad0f0ee', 'clientId', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c4128530-3c65-4b95-a199-14b11ad0f0ee', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3355cb42-fed4-4bdd-b8dc-f800634befbd', 'clientHost', 'user.session.note');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3355cb42-fed4-4bdd-b8dc-f800634befbd', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3355cb42-fed4-4bdd-b8dc-f800634befbd', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3355cb42-fed4-4bdd-b8dc-f800634befbd', 'clientHost', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3355cb42-fed4-4bdd-b8dc-f800634befbd', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2fdecedd-345a-4bb0-bf62-b0b91d2f3c06', 'clientAddress', 'user.session.note');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2fdecedd-345a-4bb0-bf62-b0b91d2f3c06', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2fdecedd-345a-4bb0-bf62-b0b91d2f3c06', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2fdecedd-345a-4bb0-bf62-b0b91d2f3c06', 'clientAddress', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2fdecedd-345a-4bb0-bf62-b0b91d2f3c06', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7ee2ac87-7941-4a64-bc52-30aefc2d9d09', 'clientId', 'user.session.note');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7ee2ac87-7941-4a64-bc52-30aefc2d9d09', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7ee2ac87-7941-4a64-bc52-30aefc2d9d09', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7ee2ac87-7941-4a64-bc52-30aefc2d9d09', 'clientId', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7ee2ac87-7941-4a64-bc52-30aefc2d9d09', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f0c52aa6-c988-4419-98ed-8f86e668a0f4', 'clientHost', 'user.session.note');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f0c52aa6-c988-4419-98ed-8f86e668a0f4', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f0c52aa6-c988-4419-98ed-8f86e668a0f4', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f0c52aa6-c988-4419-98ed-8f86e668a0f4', 'clientHost', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f0c52aa6-c988-4419-98ed-8f86e668a0f4', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0bf49369-d78e-4049-a5fc-99880e526c71', 'clientAddress', 'user.session.note');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0bf49369-d78e-4049-a5fc-99880e526c71', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0bf49369-d78e-4049-a5fc-99880e526c71', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0bf49369-d78e-4049-a5fc-99880e526c71', 'clientAddress', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0bf49369-d78e-4049-a5fc-99880e526c71', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('99e79a67-2cb2-40a9-b347-0f8208184742', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('99e79a67-2cb2-40a9-b347-0f8208184742', 'fhir_practitioner_id', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('99e79a67-2cb2-40a9-b347-0f8208184742', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('99e79a67-2cb2-40a9-b347-0f8208184742', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('99e79a67-2cb2-40a9-b347-0f8208184742', 'fhir_practitioner_id', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('864811fb-0414-4157-a531-e1198dedc02f', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('864811fb-0414-4157-a531-e1198dedc02f', 'fhir_organization_id', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('864811fb-0414-4157-a531-e1198dedc02f', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('864811fb-0414-4157-a531-e1198dedc02f', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('864811fb-0414-4157-a531-e1198dedc02f', 'fhir_organization_id', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('864811fb-0414-4157-a531-e1198dedc02f', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('bfb9cdb6-76db-4532-b8b5-29cb9c291e9a', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('bfb9cdb6-76db-4532-b8b5-29cb9c291e9a', 'fhir_practitioner_id', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('bfb9cdb6-76db-4532-b8b5-29cb9c291e9a', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('bfb9cdb6-76db-4532-b8b5-29cb9c291e9a', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('bfb9cdb6-76db-4532-b8b5-29cb9c291e9a', 'fhir_practitioner_id', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('bfb9cdb6-76db-4532-b8b5-29cb9c291e9a', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b5e21891-a97b-406d-b789-f5f85b3dd8bd', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b5e21891-a97b-406d-b789-f5f85b3dd8bd', 'fhir_organization_id', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b5e21891-a97b-406d-b789-f5f85b3dd8bd', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b5e21891-a97b-406d-b789-f5f85b3dd8bd', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b5e21891-a97b-406d-b789-f5f85b3dd8bd', 'fhir_organization_id', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b5e21891-a97b-406d-b789-f5f85b3dd8bd', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('864811fb-0414-4157-a531-e1198dedc02f', 'true', 'aggregate.attrs');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('864811fb-0414-4157-a531-e1198dedc02f', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b5e21891-a97b-406d-b789-f5f85b3dd8bd', 'true', 'aggregate.attrs');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b5e21891-a97b-406d-b789-f5f85b3dd8bd', 'true', 'multivalued');


--
-- TOC entry 4194 (class 0 OID 16646)
-- Dependencies: 268
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me) VALUES ('master', 60, 300, 60, NULL, NULL, NULL, true, false, 0, NULL, 'master', 0, NULL, false, false, false, false, 'EXTERNAL', 1800, 36000, false, false, '666fea7e-1491-48d3-83ac-229faaaa9aa6', 1800, false, NULL, false, false, false, false, 0, 1, 30, 6, 'HmacSHA1', 'totp', '02a7a345-5110-4c64-8df0-2d9addfd51ff', '1a3ed8f3-63e4-4d44-8684-7b869d4abe87', '0815a0bb-70ea-4e94-8cc5-73be5819025c', '54bc9586-79fb-423c-8c10-2f7b5c415745', '8e83faae-a002-4b5f-8c80-c8e0dfc2f527', 2592000, false, 900, true, false, '479c3659-8b02-4d4e-95fb-b1b17866b4e2', 0, false, 0, 0);
INSERT INTO public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me) VALUES ('clin', 60, 300, 300, NULL, NULL, NULL, true, false, 0, NULL, 'clin', 0, NULL, false, false, false, false, 'EXTERNAL', 1800, 36000, false, false, '4b5a5bd6-ef52-45a0-95e0-e1eaf7a3dcbc', 1800, false, NULL, false, false, false, false, 0, 1, 30, 6, 'HmacSHA1', 'totp', '9e5b0ebc-0a50-4175-a789-b6109310f54d', '596c20e0-8f0c-4ae2-a8e8-4a10ae5ad88e', '638fa959-472b-4374-836b-7470570fdf3a', '42db2e1b-ae9a-4de2-86f3-46715677c7d4', 'd3c1ae89-04cb-4a47-a49c-4ebf8bee18f0', 2592000, false, 900, true, false, '18e55257-19ab-4ad5-ba89-7b0d89a5bd80', 0, false, 0, 0);


--
-- TOC entry 4195 (class 0 OID 16679)
-- Dependencies: 269
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('_browser_header.contentSecurityPolicyReportOnly', '', 'master');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('_browser_header.xContentTypeOptions', 'nosniff', 'master');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('_browser_header.xRobotsTag', 'none', 'master');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('_browser_header.xFrameOptions', 'SAMEORIGIN', 'master');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('_browser_header.contentSecurityPolicy', 'frame-src ''self''; frame-ancestors ''self''; object-src ''none'';', 'master');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('_browser_header.xXSSProtection', '1; mode=block', 'master');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('_browser_header.strictTransportSecurity', 'max-age=31536000; includeSubDomains', 'master');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('bruteForceProtected', 'false', 'master');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('permanentLockout', 'false', 'master');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('maxFailureWaitSeconds', '900', 'master');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('minimumQuickLoginWaitSeconds', '60', 'master');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('waitIncrementSeconds', '60', 'master');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('quickLoginCheckMilliSeconds', '1000', 'master');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('maxDeltaTimeSeconds', '43200', 'master');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('failureFactor', '30', 'master');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('displayName', 'Keycloak', 'master');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('displayNameHtml', '<div class="kc-logo-text"><span>Keycloak</span></div>', 'master');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('offlineSessionMaxLifespanEnabled', 'false', 'master');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('offlineSessionMaxLifespan', '5184000', 'master');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('_browser_header.contentSecurityPolicyReportOnly', '', 'clin');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('_browser_header.xContentTypeOptions', 'nosniff', 'clin');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('_browser_header.xRobotsTag', 'none', 'clin');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('_browser_header.xFrameOptions', 'SAMEORIGIN', 'clin');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('_browser_header.contentSecurityPolicy', 'frame-src ''self''; frame-ancestors ''self''; object-src ''none'';', 'clin');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('_browser_header.xXSSProtection', '1; mode=block', 'clin');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('_browser_header.strictTransportSecurity', 'max-age=31536000; includeSubDomains', 'clin');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('bruteForceProtected', 'false', 'clin');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('permanentLockout', 'false', 'clin');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('maxFailureWaitSeconds', '900', 'clin');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('minimumQuickLoginWaitSeconds', '60', 'clin');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('waitIncrementSeconds', '60', 'clin');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('quickLoginCheckMilliSeconds', '1000', 'clin');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('maxDeltaTimeSeconds', '43200', 'clin');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('failureFactor', '30', 'clin');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('offlineSessionMaxLifespanEnabled', 'false', 'clin');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('offlineSessionMaxLifespan', '5184000', 'clin');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('actionTokenGeneratedByAdminLifespan', '43200', 'clin');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('actionTokenGeneratedByUserLifespan', '300', 'clin');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('webAuthnPolicyRpEntityName', 'keycloak', 'clin');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('webAuthnPolicySignatureAlgorithms', 'ES256', 'clin');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('webAuthnPolicyRpId', '', 'clin');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('webAuthnPolicyAttestationConveyancePreference', 'not specified', 'clin');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('webAuthnPolicyAuthenticatorAttachment', 'not specified', 'clin');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('webAuthnPolicyRequireResidentKey', 'not specified', 'clin');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('webAuthnPolicyUserVerificationRequirement', 'not specified', 'clin');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('webAuthnPolicyCreateTimeout', '0', 'clin');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('webAuthnPolicyAvoidSameAuthenticatorRegister', 'false', 'clin');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('webAuthnPolicyRpEntityNamePasswordless', 'keycloak', 'clin');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('webAuthnPolicySignatureAlgorithmsPasswordless', 'ES256', 'clin');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('webAuthnPolicyRpIdPasswordless', '', 'clin');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('webAuthnPolicyAttestationConveyancePreferencePasswordless', 'not specified', 'clin');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('webAuthnPolicyAuthenticatorAttachmentPasswordless', 'not specified', 'clin');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('webAuthnPolicyRequireResidentKeyPasswordless', 'not specified', 'clin');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('webAuthnPolicyUserVerificationRequirementPasswordless', 'not specified', 'clin');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('webAuthnPolicyCreateTimeoutPasswordless', '0', 'clin');
INSERT INTO public.realm_attribute (name, value, realm_id) VALUES ('webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless', 'false', 'clin');


--
-- TOC entry 4196 (class 0 OID 16684)
-- Dependencies: 270
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4197 (class 0 OID 16687)
-- Dependencies: 271
-- Data for Name: realm_default_roles; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.realm_default_roles (realm_id, role_id) VALUES ('master', 'bc77550a-7271-4beb-a829-4cec806b23a6');
INSERT INTO public.realm_default_roles (realm_id, role_id) VALUES ('master', '65603187-52ff-471f-9248-fd537cdcd9a6');
INSERT INTO public.realm_default_roles (realm_id, role_id) VALUES ('clin', 'b9688af1-84bc-4bbf-892d-5732be692351');
INSERT INTO public.realm_default_roles (realm_id, role_id) VALUES ('clin', 'eb2d2063-6c44-4ae8-bf9f-081a073e19fd');


--
-- TOC entry 4198 (class 0 OID 16690)
-- Dependencies: 272
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4199 (class 0 OID 16693)
-- Dependencies: 273
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.realm_events_listeners (realm_id, value) VALUES ('master', 'jboss-logging');
INSERT INTO public.realm_events_listeners (realm_id, value) VALUES ('clin', 'jboss-logging');


--
-- TOC entry 4200 (class 0 OID 16696)
-- Dependencies: 274
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4201 (class 0 OID 16701)
-- Dependencies: 275
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.realm_required_credential (type, form_label, input, secret, realm_id) VALUES ('password', 'password', true, true, 'master');
INSERT INTO public.realm_required_credential (type, form_label, input, secret, realm_id) VALUES ('password', 'password', true, true, 'clin');


--
-- TOC entry 4202 (class 0 OID 16708)
-- Dependencies: 276
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4203 (class 0 OID 16713)
-- Dependencies: 277
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4204 (class 0 OID 16716)
-- Dependencies: 278
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.redirect_uris (client_id, value) VALUES ('740d7d62-c828-439b-a4c0-6f513354894a', '/realms/master/account/*');
INSERT INTO public.redirect_uris (client_id, value) VALUES ('0fc80003-6ce5-46c2-a047-1d0e44291402', '/realms/master/account/*');
INSERT INTO public.redirect_uris (client_id, value) VALUES ('21967484-d12e-48b0-8a2d-acc885559c01', '/admin/master/console/*');
INSERT INTO public.redirect_uris (client_id, value) VALUES ('f7af93f2-37c5-4cf6-b07e-7b6620cf8458', '/realms/clin/account/*');
INSERT INTO public.redirect_uris (client_id, value) VALUES ('09e07cd8-2e94-4ce2-acbe-981d5d672371', '/realms/clin/account/*');
INSERT INTO public.redirect_uris (client_id, value) VALUES ('78e8963c-3ea0-4eee-b438-237191ebab68', '/admin/clin/console/*');
INSERT INTO public.redirect_uris (client_id, value) VALUES ('df77c1aa-6543-489f-919a-3880f58d5494', '*');
INSERT INTO public.redirect_uris (client_id, value) VALUES ('8f553005-b544-4e27-8fbc-a9a517ed6fe9', '*');
INSERT INTO public.redirect_uris (client_id, value) VALUES ('cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', '*');


--
-- TOC entry 4205 (class 0 OID 16719)
-- Dependencies: 279
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4206 (class 0 OID 16724)
-- Dependencies: 280
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('c8de26e1-8980-465a-84b9-f967674df7bf', 'VERIFY_EMAIL', 'Verify Email', 'master', true, false, 'VERIFY_EMAIL', 50);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('4da2632b-18c0-48e6-b33d-73c6da5acfb0', 'UPDATE_PROFILE', 'Update Profile', 'master', true, false, 'UPDATE_PROFILE', 40);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('d37ecb72-a976-4d1f-86a7-43358d2afa7f', 'CONFIGURE_TOTP', 'Configure OTP', 'master', true, false, 'CONFIGURE_TOTP', 10);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('42a2366e-6ffe-4907-8946-6cf72f4ba10a', 'UPDATE_PASSWORD', 'Update Password', 'master', true, false, 'UPDATE_PASSWORD', 30);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('b6416fe5-5e28-46f4-bad6-29fadcffdf1b', 'terms_and_conditions', 'Terms and Conditions', 'master', false, false, 'terms_and_conditions', 20);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('04c34f6a-ade3-4e78-b7e3-83088785e56f', 'update_user_locale', 'Update User Locale', 'master', true, false, 'update_user_locale', 1000);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('49ee78ca-31ae-4b47-9814-448ec0cb2925', 'delete_account', 'Delete Account', 'master', false, false, 'delete_account', 60);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('163a30f1-6984-428e-bda4-9b6d0af91088', 'VERIFY_EMAIL', 'Verify Email', 'clin', true, false, 'VERIFY_EMAIL', 50);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('93749da4-556a-4f36-b0a1-632652e8166c', 'UPDATE_PROFILE', 'Update Profile', 'clin', true, false, 'UPDATE_PROFILE', 40);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('b820cde1-d646-450b-a272-3e68535ad84e', 'CONFIGURE_TOTP', 'Configure OTP', 'clin', true, false, 'CONFIGURE_TOTP', 10);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('a634b397-c3ef-4c26-b3c2-2bf811bfc8ac', 'UPDATE_PASSWORD', 'Update Password', 'clin', true, false, 'UPDATE_PASSWORD', 30);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('ea375cca-2054-4f91-b875-c8ae71a4b58a', 'terms_and_conditions', 'Terms and Conditions', 'clin', false, false, 'terms_and_conditions', 20);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('f2f85261-8644-420d-b587-887a12eb8b9b', 'update_user_locale', 'Update User Locale', 'clin', true, false, 'update_user_locale', 1000);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('ee162a74-ee53-4b5d-a3a2-afe5ce3ed5b6', 'delete_account', 'Delete Account', 'clin', false, false, 'delete_account', 60);


--
-- TOC entry 4207 (class 0 OID 16731)
-- Dependencies: 281
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4208 (class 0 OID 16737)
-- Dependencies: 282
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.resource_policy (resource_id, policy_id) VALUES ('75dbaac7-f438-43ba-91f7-8e110859b6a3', '5cf293bc-e1a9-479a-b503-561e0fa99fc6');
INSERT INTO public.resource_policy (resource_id, policy_id) VALUES ('9a0dab95-5f46-4985-bbaf-f1849d2c3bee', '19bcdfb7-989c-4daf-a9ca-6b5e8951b97b');
INSERT INTO public.resource_policy (resource_id, policy_id) VALUES ('ed3961a1-41c7-429d-b3b0-4e386fba2087', '7633a042-a1ba-45c3-8955-10844bf405e1');
INSERT INTO public.resource_policy (resource_id, policy_id) VALUES ('b922db0e-398a-4b27-b0e1-59a94eca886d', 'f8768963-1c2f-46ec-a8d4-b18d9a0e73a6');
INSERT INTO public.resource_policy (resource_id, policy_id) VALUES ('aedce82d-813e-4db0-b046-19fa80cf26bd', 'eda6a66d-ad9c-4e4f-a73d-60877b2e1c52');
INSERT INTO public.resource_policy (resource_id, policy_id) VALUES ('3ff39670-a80c-44c1-ba0f-706548681b4c', '8df78ad8-7c78-4a63-af78-f405664a1046');
INSERT INTO public.resource_policy (resource_id, policy_id) VALUES ('f694439c-cb98-47f4-a734-b0bc97121509', 'fb9c26ce-060c-4dc5-a7b8-45ac7b6bfa4f');
INSERT INTO public.resource_policy (resource_id, policy_id) VALUES ('7ff1d25f-ccd7-41b6-b141-a79bb7c778b9', 'e6115285-34ec-4fa2-a088-3003ab8ba657');
INSERT INTO public.resource_policy (resource_id, policy_id) VALUES ('4f916a24-68e3-480c-9358-21e221cba83e', 'cd7122ba-e2eb-4b30-81d3-ae0831a33d01');
INSERT INTO public.resource_policy (resource_id, policy_id) VALUES ('896377dc-5b01-4702-ab6e-9d459b06390c', 'b52ca339-e25b-4959-9b51-404fa891805c');
INSERT INTO public.resource_policy (resource_id, policy_id) VALUES ('11a7ff6d-5778-4f26-803a-8475ebd19545', '6e9f1189-a7af-440f-9b88-60f34fcb97f8');
INSERT INTO public.resource_policy (resource_id, policy_id) VALUES ('aa9520b9-7dc3-48ad-a0c0-f67683fb9287', '1c75c85d-2112-4f8c-a745-06d9a255e49c');
INSERT INTO public.resource_policy (resource_id, policy_id) VALUES ('f6bd5c32-c43b-433e-80d8-f7a0bebd5f9d', '5565ee4f-f4e6-423d-b174-8eb5ae8bff2a');
INSERT INTO public.resource_policy (resource_id, policy_id) VALUES ('e9e1e3d7-bf77-4c89-8eb6-b2b496810fee', 'd5528bfa-aa34-4328-a0c0-80543c201d70');
INSERT INTO public.resource_policy (resource_id, policy_id) VALUES ('7a65d616-ef9e-47b7-a9f4-450ad3a8979f', 'b06e52c5-6635-4642-abe9-61297c878cf9');
INSERT INTO public.resource_policy (resource_id, policy_id) VALUES ('d97bb7b7-c203-4ded-9483-94d87c9fb905', '5104b014-6fe6-4086-8e50-b6038d06f23e');
INSERT INTO public.resource_policy (resource_id, policy_id) VALUES ('54b53bef-e5d6-4bbd-bf0d-02588a348420', 'fbc29587-fcba-4b81-b8f4-4c36313aeab7');


--
-- TOC entry 4209 (class 0 OID 16740)
-- Dependencies: 283
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('9a0dab95-5f46-4985-bbaf-f1849d2c3bee', '48d555c3-5dee-4a09-ab05-48ce3f3abb77');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('9a0dab95-5f46-4985-bbaf-f1849d2c3bee', '0160bf98-6451-4222-a40b-f0ae29c6aeb4');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('9a0dab95-5f46-4985-bbaf-f1849d2c3bee', '91d0726a-d669-43b8-97fc-33b874287018');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('9a0dab95-5f46-4985-bbaf-f1849d2c3bee', 'eced63df-ea65-4a3e-a4c1-c66365fef929');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('5e53732c-3d11-4019-97b0-6be98a98f26f', '48d555c3-5dee-4a09-ab05-48ce3f3abb77');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('5e53732c-3d11-4019-97b0-6be98a98f26f', '0160bf98-6451-4222-a40b-f0ae29c6aeb4');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('5e53732c-3d11-4019-97b0-6be98a98f26f', '91d0726a-d669-43b8-97fc-33b874287018');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('5e53732c-3d11-4019-97b0-6be98a98f26f', 'eced63df-ea65-4a3e-a4c1-c66365fef929');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('75dbaac7-f438-43ba-91f7-8e110859b6a3', '48d555c3-5dee-4a09-ab05-48ce3f3abb77');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('75dbaac7-f438-43ba-91f7-8e110859b6a3', '0160bf98-6451-4222-a40b-f0ae29c6aeb4');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('75dbaac7-f438-43ba-91f7-8e110859b6a3', '91d0726a-d669-43b8-97fc-33b874287018');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('75dbaac7-f438-43ba-91f7-8e110859b6a3', 'eced63df-ea65-4a3e-a4c1-c66365fef929');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('4bdc542d-011c-48ef-a31d-fe5d0724cbbb', '48d555c3-5dee-4a09-ab05-48ce3f3abb77');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('4bdc542d-011c-48ef-a31d-fe5d0724cbbb', '0160bf98-6451-4222-a40b-f0ae29c6aeb4');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('4bdc542d-011c-48ef-a31d-fe5d0724cbbb', '91d0726a-d669-43b8-97fc-33b874287018');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('4bdc542d-011c-48ef-a31d-fe5d0724cbbb', 'eced63df-ea65-4a3e-a4c1-c66365fef929');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('4f916a24-68e3-480c-9358-21e221cba83e', '48d555c3-5dee-4a09-ab05-48ce3f3abb77');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('4f916a24-68e3-480c-9358-21e221cba83e', '0160bf98-6451-4222-a40b-f0ae29c6aeb4');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('4f916a24-68e3-480c-9358-21e221cba83e', '91d0726a-d669-43b8-97fc-33b874287018');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('4f916a24-68e3-480c-9358-21e221cba83e', 'eced63df-ea65-4a3e-a4c1-c66365fef929');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('aedce82d-813e-4db0-b046-19fa80cf26bd', '48d555c3-5dee-4a09-ab05-48ce3f3abb77');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('aedce82d-813e-4db0-b046-19fa80cf26bd', '0160bf98-6451-4222-a40b-f0ae29c6aeb4');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('aedce82d-813e-4db0-b046-19fa80cf26bd', '91d0726a-d669-43b8-97fc-33b874287018');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('aedce82d-813e-4db0-b046-19fa80cf26bd', 'eced63df-ea65-4a3e-a4c1-c66365fef929');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('3ff39670-a80c-44c1-ba0f-706548681b4c', '48d555c3-5dee-4a09-ab05-48ce3f3abb77');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('3ff39670-a80c-44c1-ba0f-706548681b4c', '0160bf98-6451-4222-a40b-f0ae29c6aeb4');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('3ff39670-a80c-44c1-ba0f-706548681b4c', '91d0726a-d669-43b8-97fc-33b874287018');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('3ff39670-a80c-44c1-ba0f-706548681b4c', 'eced63df-ea65-4a3e-a4c1-c66365fef929');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('f694439c-cb98-47f4-a734-b0bc97121509', '48d555c3-5dee-4a09-ab05-48ce3f3abb77');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('f694439c-cb98-47f4-a734-b0bc97121509', '0160bf98-6451-4222-a40b-f0ae29c6aeb4');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('f694439c-cb98-47f4-a734-b0bc97121509', '91d0726a-d669-43b8-97fc-33b874287018');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('f694439c-cb98-47f4-a734-b0bc97121509', 'eced63df-ea65-4a3e-a4c1-c66365fef929');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('7ff1d25f-ccd7-41b6-b141-a79bb7c778b9', '48d555c3-5dee-4a09-ab05-48ce3f3abb77');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('7ff1d25f-ccd7-41b6-b141-a79bb7c778b9', '0160bf98-6451-4222-a40b-f0ae29c6aeb4');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('7ff1d25f-ccd7-41b6-b141-a79bb7c778b9', '91d0726a-d669-43b8-97fc-33b874287018');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('7ff1d25f-ccd7-41b6-b141-a79bb7c778b9', 'eced63df-ea65-4a3e-a4c1-c66365fef929');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('896377dc-5b01-4702-ab6e-9d459b06390c', '48d555c3-5dee-4a09-ab05-48ce3f3abb77');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('896377dc-5b01-4702-ab6e-9d459b06390c', '0160bf98-6451-4222-a40b-f0ae29c6aeb4');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('896377dc-5b01-4702-ab6e-9d459b06390c', '91d0726a-d669-43b8-97fc-33b874287018');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('896377dc-5b01-4702-ab6e-9d459b06390c', 'eced63df-ea65-4a3e-a4c1-c66365fef929');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('11a7ff6d-5778-4f26-803a-8475ebd19545', '48d555c3-5dee-4a09-ab05-48ce3f3abb77');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('11a7ff6d-5778-4f26-803a-8475ebd19545', '0160bf98-6451-4222-a40b-f0ae29c6aeb4');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('11a7ff6d-5778-4f26-803a-8475ebd19545', '91d0726a-d669-43b8-97fc-33b874287018');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('11a7ff6d-5778-4f26-803a-8475ebd19545', 'eced63df-ea65-4a3e-a4c1-c66365fef929');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('aa9520b9-7dc3-48ad-a0c0-f67683fb9287', '48d555c3-5dee-4a09-ab05-48ce3f3abb77');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('aa9520b9-7dc3-48ad-a0c0-f67683fb9287', '0160bf98-6451-4222-a40b-f0ae29c6aeb4');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('aa9520b9-7dc3-48ad-a0c0-f67683fb9287', '91d0726a-d669-43b8-97fc-33b874287018');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('aa9520b9-7dc3-48ad-a0c0-f67683fb9287', 'eced63df-ea65-4a3e-a4c1-c66365fef929');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('f6bd5c32-c43b-433e-80d8-f7a0bebd5f9d', '48d555c3-5dee-4a09-ab05-48ce3f3abb77');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('f6bd5c32-c43b-433e-80d8-f7a0bebd5f9d', '0160bf98-6451-4222-a40b-f0ae29c6aeb4');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('f6bd5c32-c43b-433e-80d8-f7a0bebd5f9d', '91d0726a-d669-43b8-97fc-33b874287018');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('f6bd5c32-c43b-433e-80d8-f7a0bebd5f9d', 'eced63df-ea65-4a3e-a4c1-c66365fef929');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('e9e1e3d7-bf77-4c89-8eb6-b2b496810fee', '48d555c3-5dee-4a09-ab05-48ce3f3abb77');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('e9e1e3d7-bf77-4c89-8eb6-b2b496810fee', '0160bf98-6451-4222-a40b-f0ae29c6aeb4');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('e9e1e3d7-bf77-4c89-8eb6-b2b496810fee', '91d0726a-d669-43b8-97fc-33b874287018');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('e9e1e3d7-bf77-4c89-8eb6-b2b496810fee', 'eced63df-ea65-4a3e-a4c1-c66365fef929');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('7a65d616-ef9e-47b7-a9f4-450ad3a8979f', '48d555c3-5dee-4a09-ab05-48ce3f3abb77');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('7a65d616-ef9e-47b7-a9f4-450ad3a8979f', '0160bf98-6451-4222-a40b-f0ae29c6aeb4');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('7a65d616-ef9e-47b7-a9f4-450ad3a8979f', '91d0726a-d669-43b8-97fc-33b874287018');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('7a65d616-ef9e-47b7-a9f4-450ad3a8979f', 'eced63df-ea65-4a3e-a4c1-c66365fef929');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('d97bb7b7-c203-4ded-9483-94d87c9fb905', '48d555c3-5dee-4a09-ab05-48ce3f3abb77');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('d97bb7b7-c203-4ded-9483-94d87c9fb905', '0160bf98-6451-4222-a40b-f0ae29c6aeb4');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('d97bb7b7-c203-4ded-9483-94d87c9fb905', '91d0726a-d669-43b8-97fc-33b874287018');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('d97bb7b7-c203-4ded-9483-94d87c9fb905', 'eced63df-ea65-4a3e-a4c1-c66365fef929');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('54b53bef-e5d6-4bbd-bf0d-02588a348420', '48d555c3-5dee-4a09-ab05-48ce3f3abb77');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('54b53bef-e5d6-4bbd-bf0d-02588a348420', '0160bf98-6451-4222-a40b-f0ae29c6aeb4');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('54b53bef-e5d6-4bbd-bf0d-02588a348420', '91d0726a-d669-43b8-97fc-33b874287018');
INSERT INTO public.resource_scope (resource_id, scope_id) VALUES ('54b53bef-e5d6-4bbd-bf0d-02588a348420', 'eced63df-ea65-4a3e-a4c1-c66365fef929');


--
-- TOC entry 4210 (class 0 OID 16743)
-- Dependencies: 284
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) VALUES ('cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', true, '0', 0);


--
-- TOC entry 4211 (class 0 OID 16748)
-- Dependencies: 285
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4212 (class 0 OID 16753)
-- Dependencies: 286
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) VALUES ('09932e6c-5f26-4322-b346-83e6282bd81a', 'Default Policy', 'A policy that grants access only for users within this realm', 'js', '0', '0', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', NULL);
INSERT INTO public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) VALUES ('564f17f2-b764-4205-b51a-11c0505cfa37', 'Default Permission', 'A permission that applies to the default resource type', 'resource', '1', '0', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', NULL);
INSERT INTO public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) VALUES ('5ed10474-21bf-40e9-bbb3-f80eab73baaa', 'is_system', NULL, 'client', '1', '0', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', NULL);
INSERT INTO public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) VALUES ('de9e7111-fc7c-4e3c-9462-40c25d524f94', 'is_prescriber', NULL, 'role', '1', '0', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', NULL);
INSERT INTO public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) VALUES ('f9b6ce0f-635b-4ba0-961b-39f98ba3fb6b', 'is_genetician', NULL, 'role', '1', '0', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', NULL);
INSERT INTO public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) VALUES ('5cf293bc-e1a9-479a-b503-561e0fa99fc6', 'Organization_CRUD', NULL, 'scope', '0', '0', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', NULL);
INSERT INTO public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) VALUES ('29b6112f-abdc-407c-888f-37915d530d29', 'is_administrator', NULL, 'role', '1', '0', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', NULL);
INSERT INTO public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) VALUES ('9391162c-e6ba-48fd-99bd-31c1ef627695', 'OrganizationAffiliation_CRUD', NULL, 'scope', '0', '0', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', NULL);
INSERT INTO public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) VALUES ('19bcdfb7-989c-4daf-a9ca-6b5e8951b97b', 'Practitioner_CRUD', NULL, 'scope', '0', '0', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', NULL);
INSERT INTO public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) VALUES ('67007f3b-7afc-4e4a-99c3-7953f2b5977a', 'PractitionerRole_CRUD', NULL, 'scope', '0', '0', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', NULL);
INSERT INTO public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) VALUES ('fb9c26ce-060c-4dc5-a7b8-45ac7b6bfa4f', 'ValueSet_CRUD', NULL, 'scope', '0', '0', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', NULL);
INSERT INTO public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) VALUES ('e6115285-34ec-4fa2-a088-3003ab8ba657', 'CodeSystem_CRUD', NULL, 'scope', '0', '0', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', NULL);
INSERT INTO public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) VALUES ('cd7122ba-e2eb-4b30-81d3-ae0831a33d01', 'StructureDefinition_CRUD', NULL, 'scope', '0', '0', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', NULL);
INSERT INTO public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) VALUES ('7633a042-a1ba-45c3-8955-10844bf405e1', 'Metadata', NULL, 'resource', '0', '0', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', NULL);
INSERT INTO public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) VALUES ('f8768963-1c2f-46ec-a8d4-b18d9a0e73a6', 'Export', NULL, 'resource', '0', '0', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', NULL);
INSERT INTO public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) VALUES ('8df78ad8-7c78-4a63-af78-f405664a1046', 'AuditEvent_CRUD', NULL, 'scope', '0', '0', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', NULL);
INSERT INTO public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) VALUES ('eda6a66d-ad9c-4e4f-a73d-60877b2e1c52', 'Bundle_CRUD', NULL, 'scope', '0', '0', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', NULL);
INSERT INTO public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) VALUES ('b52ca339-e25b-4959-9b51-404fa891805c', 'ServiceRequest_CRUD', NULL, 'scope', '0', '0', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', NULL);
INSERT INTO public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) VALUES ('6e9f1189-a7af-440f-9b88-60f34fcb97f8', 'Patient_CRUD', NULL, 'scope', '0', '0', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', NULL);
INSERT INTO public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) VALUES ('1c75c85d-2112-4f8c-a745-06d9a255e49c', 'Person_CRUD', NULL, 'scope', '0', '0', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', NULL);
INSERT INTO public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) VALUES ('5565ee4f-f4e6-423d-b174-8eb5ae8bff2a', 'Observation_CRUD', NULL, 'scope', '0', '0', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', NULL);
INSERT INTO public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) VALUES ('d5528bfa-aa34-4328-a0c0-80543c201d70', 'ClinicalImpression_CRUD', NULL, 'scope', '0', '0', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', NULL);
INSERT INTO public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) VALUES ('b06e52c5-6635-4642-abe9-61297c878cf9', 'Task_CRUD', NULL, 'scope', '0', '0', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', NULL);
INSERT INTO public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) VALUES ('5104b014-6fe6-4086-8e50-b6038d06f23e', 'DocumentReference_CRUD', NULL, 'scope', '0', '0', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', NULL);
INSERT INTO public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) VALUES ('fbc29587-fcba-4b81-b8f4-4c36313aeab7', 'Specimen_CRUD', NULL, 'scope', '0', '0', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', NULL);


--
-- TOC entry 4213 (class 0 OID 16758)
-- Dependencies: 287
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) VALUES ('a54fbc03-e123-41ef-9cde-8ed06fe1e647', 'Default Resource', 'urn:clin-acl:resources:default', NULL, 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', false, NULL);
INSERT INTO public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) VALUES ('9a0dab95-5f46-4985-bbaf-f1849d2c3bee', 'Practitioner', NULL, NULL, 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', false, 'Practitioner');
INSERT INTO public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) VALUES ('5e53732c-3d11-4019-97b0-6be98a98f26f', 'PractitionerRole', NULL, NULL, 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', false, 'PractitionerRole');
INSERT INTO public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) VALUES ('75dbaac7-f438-43ba-91f7-8e110859b6a3', 'Organization', NULL, NULL, 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', false, 'Organization');
INSERT INTO public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) VALUES ('ed3961a1-41c7-429d-b3b0-4e386fba2087', 'Metadata', NULL, NULL, 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', false, 'Metadata');
INSERT INTO public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) VALUES ('b922db0e-398a-4b27-b0e1-59a94eca886d', 'Export', NULL, NULL, 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', false, 'Export');
INSERT INTO public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) VALUES ('3ff39670-a80c-44c1-ba0f-706548681b4c', 'AuditEvent', NULL, NULL, 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', false, 'AuditEvent');
INSERT INTO public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) VALUES ('4bdc542d-011c-48ef-a31d-fe5d0724cbbb', 'OrganizationAffiliation', NULL, NULL, 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', false, 'OrganizationAffiliation');
INSERT INTO public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) VALUES ('4f916a24-68e3-480c-9358-21e221cba83e', 'StructureDefinition', NULL, NULL, 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', false, 'StructureDefinition');
INSERT INTO public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) VALUES ('aedce82d-813e-4db0-b046-19fa80cf26bd', 'Bundle', NULL, NULL, 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', false, 'Bundle');
INSERT INTO public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) VALUES ('f694439c-cb98-47f4-a734-b0bc97121509', 'ValueSet', NULL, NULL, 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', false, 'ValueSet');
INSERT INTO public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) VALUES ('7ff1d25f-ccd7-41b6-b141-a79bb7c778b9', 'CodeSystem', NULL, NULL, 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', false, 'CodeSystem');
INSERT INTO public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) VALUES ('896377dc-5b01-4702-ab6e-9d459b06390c', 'ServiceRequest', NULL, NULL, 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', false, 'ServiceRequest');
INSERT INTO public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) VALUES ('11a7ff6d-5778-4f26-803a-8475ebd19545', 'Patient', NULL, NULL, 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', false, 'Patient');
INSERT INTO public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) VALUES ('aa9520b9-7dc3-48ad-a0c0-f67683fb9287', 'Person', NULL, NULL, 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', false, 'Person');
INSERT INTO public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) VALUES ('f6bd5c32-c43b-433e-80d8-f7a0bebd5f9d', 'Observation', NULL, NULL, 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', false, 'Observation');
INSERT INTO public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) VALUES ('e9e1e3d7-bf77-4c89-8eb6-b2b496810fee', 'ClinicalImpression', NULL, NULL, 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', false, 'ClinicalImpression');
INSERT INTO public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) VALUES ('7a65d616-ef9e-47b7-a9f4-450ad3a8979f', 'Task', NULL, NULL, 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', false, 'Task');
INSERT INTO public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) VALUES ('d97bb7b7-c203-4ded-9483-94d87c9fb905', 'DocumentReference', NULL, NULL, 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', false, 'DocumentReference');
INSERT INTO public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) VALUES ('54b53bef-e5d6-4bbd-bf0d-02588a348420', 'Specimen', NULL, NULL, 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', false, 'Specimen');


--
-- TOC entry 4214 (class 0 OID 16764)
-- Dependencies: 288
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) VALUES ('48d555c3-5dee-4a09-ab05-48ce3f3abb77', 'create', NULL, 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', NULL);
INSERT INTO public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) VALUES ('91d0726a-d669-43b8-97fc-33b874287018', 'read', NULL, 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', NULL);
INSERT INTO public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) VALUES ('0160bf98-6451-4222-a40b-f0ae29c6aeb4', 'update', NULL, 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', NULL);
INSERT INTO public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) VALUES ('eced63df-ea65-4a3e-a4c1-c66365fef929', 'delete', NULL, 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', NULL);


--
-- TOC entry 4215 (class 0 OID 16769)
-- Dependencies: 289
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.resource_uris (resource_id, value) VALUES ('a54fbc03-e123-41ef-9cde-8ed06fe1e647', '/*');


--
-- TOC entry 4216 (class 0 OID 16772)
-- Dependencies: 290
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4217 (class 0 OID 16777)
-- Dependencies: 291
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('0fc80003-6ce5-46c2-a047-1d0e44291402', 'd31a5d16-be94-4795-a857-8933093fb18e');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('09e07cd8-2e94-4ce2-acbe-981d5d672371', '43d9eeda-d8c0-46e2-bc15-1b7049bd3824');


--
-- TOC entry 4218 (class 0 OID 16780)
-- Dependencies: 292
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('48d555c3-5dee-4a09-ab05-48ce3f3abb77', '5cf293bc-e1a9-479a-b503-561e0fa99fc6');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('0160bf98-6451-4222-a40b-f0ae29c6aeb4', '5cf293bc-e1a9-479a-b503-561e0fa99fc6');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('91d0726a-d669-43b8-97fc-33b874287018', '5cf293bc-e1a9-479a-b503-561e0fa99fc6');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('eced63df-ea65-4a3e-a4c1-c66365fef929', '5cf293bc-e1a9-479a-b503-561e0fa99fc6');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('48d555c3-5dee-4a09-ab05-48ce3f3abb77', '9391162c-e6ba-48fd-99bd-31c1ef627695');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('0160bf98-6451-4222-a40b-f0ae29c6aeb4', '9391162c-e6ba-48fd-99bd-31c1ef627695');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('91d0726a-d669-43b8-97fc-33b874287018', '9391162c-e6ba-48fd-99bd-31c1ef627695');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('eced63df-ea65-4a3e-a4c1-c66365fef929', '9391162c-e6ba-48fd-99bd-31c1ef627695');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('48d555c3-5dee-4a09-ab05-48ce3f3abb77', '19bcdfb7-989c-4daf-a9ca-6b5e8951b97b');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('0160bf98-6451-4222-a40b-f0ae29c6aeb4', '19bcdfb7-989c-4daf-a9ca-6b5e8951b97b');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('91d0726a-d669-43b8-97fc-33b874287018', '19bcdfb7-989c-4daf-a9ca-6b5e8951b97b');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('eced63df-ea65-4a3e-a4c1-c66365fef929', '19bcdfb7-989c-4daf-a9ca-6b5e8951b97b');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('48d555c3-5dee-4a09-ab05-48ce3f3abb77', '67007f3b-7afc-4e4a-99c3-7953f2b5977a');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('0160bf98-6451-4222-a40b-f0ae29c6aeb4', '67007f3b-7afc-4e4a-99c3-7953f2b5977a');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('91d0726a-d669-43b8-97fc-33b874287018', '67007f3b-7afc-4e4a-99c3-7953f2b5977a');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('eced63df-ea65-4a3e-a4c1-c66365fef929', '67007f3b-7afc-4e4a-99c3-7953f2b5977a');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('48d555c3-5dee-4a09-ab05-48ce3f3abb77', 'fb9c26ce-060c-4dc5-a7b8-45ac7b6bfa4f');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('0160bf98-6451-4222-a40b-f0ae29c6aeb4', 'fb9c26ce-060c-4dc5-a7b8-45ac7b6bfa4f');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('91d0726a-d669-43b8-97fc-33b874287018', 'fb9c26ce-060c-4dc5-a7b8-45ac7b6bfa4f');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('eced63df-ea65-4a3e-a4c1-c66365fef929', 'fb9c26ce-060c-4dc5-a7b8-45ac7b6bfa4f');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('48d555c3-5dee-4a09-ab05-48ce3f3abb77', 'e6115285-34ec-4fa2-a088-3003ab8ba657');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('0160bf98-6451-4222-a40b-f0ae29c6aeb4', 'e6115285-34ec-4fa2-a088-3003ab8ba657');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('91d0726a-d669-43b8-97fc-33b874287018', 'e6115285-34ec-4fa2-a088-3003ab8ba657');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('eced63df-ea65-4a3e-a4c1-c66365fef929', 'e6115285-34ec-4fa2-a088-3003ab8ba657');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('48d555c3-5dee-4a09-ab05-48ce3f3abb77', 'cd7122ba-e2eb-4b30-81d3-ae0831a33d01');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('0160bf98-6451-4222-a40b-f0ae29c6aeb4', 'cd7122ba-e2eb-4b30-81d3-ae0831a33d01');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('91d0726a-d669-43b8-97fc-33b874287018', 'cd7122ba-e2eb-4b30-81d3-ae0831a33d01');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('eced63df-ea65-4a3e-a4c1-c66365fef929', 'cd7122ba-e2eb-4b30-81d3-ae0831a33d01');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('48d555c3-5dee-4a09-ab05-48ce3f3abb77', 'eda6a66d-ad9c-4e4f-a73d-60877b2e1c52');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('0160bf98-6451-4222-a40b-f0ae29c6aeb4', 'eda6a66d-ad9c-4e4f-a73d-60877b2e1c52');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('91d0726a-d669-43b8-97fc-33b874287018', 'eda6a66d-ad9c-4e4f-a73d-60877b2e1c52');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('eced63df-ea65-4a3e-a4c1-c66365fef929', 'eda6a66d-ad9c-4e4f-a73d-60877b2e1c52');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('48d555c3-5dee-4a09-ab05-48ce3f3abb77', '8df78ad8-7c78-4a63-af78-f405664a1046');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('0160bf98-6451-4222-a40b-f0ae29c6aeb4', '8df78ad8-7c78-4a63-af78-f405664a1046');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('91d0726a-d669-43b8-97fc-33b874287018', '8df78ad8-7c78-4a63-af78-f405664a1046');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('eced63df-ea65-4a3e-a4c1-c66365fef929', '8df78ad8-7c78-4a63-af78-f405664a1046');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('48d555c3-5dee-4a09-ab05-48ce3f3abb77', 'b52ca339-e25b-4959-9b51-404fa891805c');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('0160bf98-6451-4222-a40b-f0ae29c6aeb4', 'b52ca339-e25b-4959-9b51-404fa891805c');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('91d0726a-d669-43b8-97fc-33b874287018', 'b52ca339-e25b-4959-9b51-404fa891805c');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('eced63df-ea65-4a3e-a4c1-c66365fef929', 'b52ca339-e25b-4959-9b51-404fa891805c');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('48d555c3-5dee-4a09-ab05-48ce3f3abb77', '6e9f1189-a7af-440f-9b88-60f34fcb97f8');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('0160bf98-6451-4222-a40b-f0ae29c6aeb4', '6e9f1189-a7af-440f-9b88-60f34fcb97f8');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('91d0726a-d669-43b8-97fc-33b874287018', '6e9f1189-a7af-440f-9b88-60f34fcb97f8');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('eced63df-ea65-4a3e-a4c1-c66365fef929', '6e9f1189-a7af-440f-9b88-60f34fcb97f8');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('48d555c3-5dee-4a09-ab05-48ce3f3abb77', '1c75c85d-2112-4f8c-a745-06d9a255e49c');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('0160bf98-6451-4222-a40b-f0ae29c6aeb4', '1c75c85d-2112-4f8c-a745-06d9a255e49c');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('91d0726a-d669-43b8-97fc-33b874287018', '1c75c85d-2112-4f8c-a745-06d9a255e49c');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('eced63df-ea65-4a3e-a4c1-c66365fef929', '1c75c85d-2112-4f8c-a745-06d9a255e49c');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('48d555c3-5dee-4a09-ab05-48ce3f3abb77', '5565ee4f-f4e6-423d-b174-8eb5ae8bff2a');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('0160bf98-6451-4222-a40b-f0ae29c6aeb4', '5565ee4f-f4e6-423d-b174-8eb5ae8bff2a');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('91d0726a-d669-43b8-97fc-33b874287018', '5565ee4f-f4e6-423d-b174-8eb5ae8bff2a');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('eced63df-ea65-4a3e-a4c1-c66365fef929', '5565ee4f-f4e6-423d-b174-8eb5ae8bff2a');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('48d555c3-5dee-4a09-ab05-48ce3f3abb77', 'd5528bfa-aa34-4328-a0c0-80543c201d70');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('0160bf98-6451-4222-a40b-f0ae29c6aeb4', 'd5528bfa-aa34-4328-a0c0-80543c201d70');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('91d0726a-d669-43b8-97fc-33b874287018', 'd5528bfa-aa34-4328-a0c0-80543c201d70');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('eced63df-ea65-4a3e-a4c1-c66365fef929', 'd5528bfa-aa34-4328-a0c0-80543c201d70');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('48d555c3-5dee-4a09-ab05-48ce3f3abb77', 'b06e52c5-6635-4642-abe9-61297c878cf9');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('0160bf98-6451-4222-a40b-f0ae29c6aeb4', 'b06e52c5-6635-4642-abe9-61297c878cf9');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('91d0726a-d669-43b8-97fc-33b874287018', 'b06e52c5-6635-4642-abe9-61297c878cf9');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('eced63df-ea65-4a3e-a4c1-c66365fef929', 'b06e52c5-6635-4642-abe9-61297c878cf9');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('48d555c3-5dee-4a09-ab05-48ce3f3abb77', '5104b014-6fe6-4086-8e50-b6038d06f23e');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('0160bf98-6451-4222-a40b-f0ae29c6aeb4', '5104b014-6fe6-4086-8e50-b6038d06f23e');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('91d0726a-d669-43b8-97fc-33b874287018', '5104b014-6fe6-4086-8e50-b6038d06f23e');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('eced63df-ea65-4a3e-a4c1-c66365fef929', '5104b014-6fe6-4086-8e50-b6038d06f23e');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('48d555c3-5dee-4a09-ab05-48ce3f3abb77', 'fbc29587-fcba-4b81-b8f4-4c36313aeab7');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('0160bf98-6451-4222-a40b-f0ae29c6aeb4', 'fbc29587-fcba-4b81-b8f4-4c36313aeab7');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('91d0726a-d669-43b8-97fc-33b874287018', 'fbc29587-fcba-4b81-b8f4-4c36313aeab7');
INSERT INTO public.scope_policy (scope_id, policy_id) VALUES ('eced63df-ea65-4a3e-a4c1-c66365fef929', 'fbc29587-fcba-4b81-b8f4-4c36313aeab7');


--
-- TOC entry 4219 (class 0 OID 16783)
-- Dependencies: 293
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.user_attribute (name, value, user_id, id) VALUES ('fhir_practitioner_id', 'PR00002', 'adc23cb0-f482-44c9-a518-9fc4047cf6bb', 'b8f66395-0ded-44f6-b60d-cfa45b1f8bb5');
INSERT INTO public.user_attribute (name, value, user_id, id) VALUES ('fhir_practitioner_id', 'PR00001', '1ed2fbca-d650-4284-9917-5416b8d44bd8', 'd8c66cfa-5363-444f-86ad-157943b94916');
INSERT INTO public.user_attribute (name, value, user_id, id) VALUES ('fhir_practitioner_id', 'PR00004', '1d933423-4975-4aef-909d-48239ef368ae', 'e33cfad7-2217-45ac-85f1-234362f23479');
INSERT INTO public.user_attribute (name, value, user_id, id) VALUES ('fhir_practitioner_id', 'PR00003', '33c2c7af-640b-4e4b-9682-681fc929d924', 'f6ef200e-fc69-41e7-9ccd-95f6445966e3');


--
-- TOC entry 4220 (class 0 OID 16789)
-- Dependencies: 294
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4221 (class 0 OID 16794)
-- Dependencies: 295
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4222 (class 0 OID 16797)
-- Dependencies: 296
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) VALUES ('c2892a6b-4d50-4730-90c4-116e2fc8fadc', NULL, 'db2db0aa-88eb-45e6-ab24-1c59a0d41a8b', false, true, NULL, NULL, NULL, 'master', 'admin', 1683126063053, NULL, 0);
INSERT INTO public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) VALUES ('7674ab9c-f5e9-4e9e-b0ae-f36e92694f20', NULL, '6e113319-e9cf-48b1-ae99-cc1cef62f8a6', false, true, NULL, NULL, NULL, 'clin', 'service-account-clin-system', 1683126974779, '8f553005-b544-4e27-8fbc-a9a517ed6fe9', 0);
INSERT INTO public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) VALUES ('b2492ed4-a90c-405e-a4fb-6355e7563115', NULL, '07bcf7b0-9c0d-48ae-a86f-7077816181e6', false, true, NULL, NULL, NULL, 'clin', 'service-account-clin-acl', 1683127059324, 'cc2a6ae7-b199-4c5d-b5c2-91dbccac0d5e', 0);
INSERT INTO public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) VALUES ('1ed2fbca-d650-4284-9917-5416b8d44bd8', NULL, '38423950-6639-4c8c-84cd-99e36ef89402', false, true, NULL, NULL, NULL, 'clin', 'chusj', 1683127320742, NULL, 0);
INSERT INTO public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) VALUES ('adc23cb0-f482-44c9-a518-9fc4047cf6bb', NULL, '9e81ced1-9102-4dc4-b034-c44567324362', false, true, NULL, NULL, NULL, 'clin', 'chus', 1683127407032, NULL, 0);
INSERT INTO public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) VALUES ('1d933423-4975-4aef-909d-48239ef368ae', NULL, '0562e1b4-df75-4c35-9af3-b67411fb5f05', false, true, NULL, NULL, NULL, 'clin', 'ldm-chus', 1683127463081, NULL, 0);
INSERT INTO public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) VALUES ('33c2c7af-640b-4e4b-9682-681fc929d924', NULL, '61b8d346-566d-4e11-a49b-89e6cb0f5abb', false, true, NULL, NULL, NULL, 'clin', 'ldm-chusj', 1683127503597, NULL, 0);


--
-- TOC entry 4223 (class 0 OID 16805)
-- Dependencies: 297
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4224 (class 0 OID 16810)
-- Dependencies: 298
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4225 (class 0 OID 16815)
-- Dependencies: 299
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4226 (class 0 OID 16820)
-- Dependencies: 300
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4227 (class 0 OID 16825)
-- Dependencies: 301
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.user_group_membership (group_id, user_id) VALUES ('43317539-da80-4603-9ff0-75ebe43e2dd1', 'adc23cb0-f482-44c9-a518-9fc4047cf6bb');
INSERT INTO public.user_group_membership (group_id, user_id) VALUES ('0002f2ea-a61f-4531-bcc5-cdeec94a7762', '1ed2fbca-d650-4284-9917-5416b8d44bd8');
INSERT INTO public.user_group_membership (group_id, user_id) VALUES ('916741d3-5dae-4a73-91a0-a4a28f845bc3', '1d933423-4975-4aef-909d-48239ef368ae');
INSERT INTO public.user_group_membership (group_id, user_id) VALUES ('7efc60cc-14b8-411e-84e8-04b683e63ae9', '33c2c7af-640b-4e4b-9682-681fc929d924');


--
-- TOC entry 4228 (class 0 OID 16828)
-- Dependencies: 302
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4229 (class 0 OID 16832)
-- Dependencies: 303
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('bc77550a-7271-4beb-a829-4cec806b23a6', 'c2892a6b-4d50-4730-90c4-116e2fc8fadc');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('65603187-52ff-471f-9248-fd537cdcd9a6', 'c2892a6b-4d50-4730-90c4-116e2fc8fadc');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('d31a5d16-be94-4795-a857-8933093fb18e', 'c2892a6b-4d50-4730-90c4-116e2fc8fadc');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('3df37bdc-beff-4411-bfca-db07a16215f8', 'c2892a6b-4d50-4730-90c4-116e2fc8fadc');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('a55a6883-a186-4dad-aa5f-6ba0c9981ae4', 'c2892a6b-4d50-4730-90c4-116e2fc8fadc');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('eb2d2063-6c44-4ae8-bf9f-081a073e19fd', '7674ab9c-f5e9-4e9e-b0ae-f36e92694f20');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('b9688af1-84bc-4bbf-892d-5732be692351', '7674ab9c-f5e9-4e9e-b0ae-f36e92694f20');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('8225db5a-8cb6-4040-ad0d-337d689207da', '7674ab9c-f5e9-4e9e-b0ae-f36e92694f20');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('43d9eeda-d8c0-46e2-bc15-1b7049bd3824', '7674ab9c-f5e9-4e9e-b0ae-f36e92694f20');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('eb2d2063-6c44-4ae8-bf9f-081a073e19fd', 'b2492ed4-a90c-405e-a4fb-6355e7563115');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('b9688af1-84bc-4bbf-892d-5732be692351', 'b2492ed4-a90c-405e-a4fb-6355e7563115');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('8225db5a-8cb6-4040-ad0d-337d689207da', 'b2492ed4-a90c-405e-a4fb-6355e7563115');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('43d9eeda-d8c0-46e2-bc15-1b7049bd3824', 'b2492ed4-a90c-405e-a4fb-6355e7563115');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('56203064-25da-4fb1-8a34-ff41d538d28a', 'b2492ed4-a90c-405e-a4fb-6355e7563115');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('eb2d2063-6c44-4ae8-bf9f-081a073e19fd', '1ed2fbca-d650-4284-9917-5416b8d44bd8');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('b9688af1-84bc-4bbf-892d-5732be692351', '1ed2fbca-d650-4284-9917-5416b8d44bd8');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('8225db5a-8cb6-4040-ad0d-337d689207da', '1ed2fbca-d650-4284-9917-5416b8d44bd8');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('43d9eeda-d8c0-46e2-bc15-1b7049bd3824', '1ed2fbca-d650-4284-9917-5416b8d44bd8');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('8604cce2-1de7-4326-950f-9473751b9b95', '1ed2fbca-d650-4284-9917-5416b8d44bd8');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('eb2d2063-6c44-4ae8-bf9f-081a073e19fd', 'adc23cb0-f482-44c9-a518-9fc4047cf6bb');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('b9688af1-84bc-4bbf-892d-5732be692351', 'adc23cb0-f482-44c9-a518-9fc4047cf6bb');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('8225db5a-8cb6-4040-ad0d-337d689207da', 'adc23cb0-f482-44c9-a518-9fc4047cf6bb');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('43d9eeda-d8c0-46e2-bc15-1b7049bd3824', 'adc23cb0-f482-44c9-a518-9fc4047cf6bb');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('8604cce2-1de7-4326-950f-9473751b9b95', 'adc23cb0-f482-44c9-a518-9fc4047cf6bb');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('eb2d2063-6c44-4ae8-bf9f-081a073e19fd', '1d933423-4975-4aef-909d-48239ef368ae');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('b9688af1-84bc-4bbf-892d-5732be692351', '1d933423-4975-4aef-909d-48239ef368ae');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('8225db5a-8cb6-4040-ad0d-337d689207da', '1d933423-4975-4aef-909d-48239ef368ae');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('43d9eeda-d8c0-46e2-bc15-1b7049bd3824', '1d933423-4975-4aef-909d-48239ef368ae');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('2ee5ec6b-46da-4988-9967-949a327f5ffd', '1d933423-4975-4aef-909d-48239ef368ae');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('eb2d2063-6c44-4ae8-bf9f-081a073e19fd', '33c2c7af-640b-4e4b-9682-681fc929d924');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('b9688af1-84bc-4bbf-892d-5732be692351', '33c2c7af-640b-4e4b-9682-681fc929d924');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('8225db5a-8cb6-4040-ad0d-337d689207da', '33c2c7af-640b-4e4b-9682-681fc929d924');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('43d9eeda-d8c0-46e2-bc15-1b7049bd3824', '33c2c7af-640b-4e4b-9682-681fc929d924');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('2ee5ec6b-46da-4988-9967-949a327f5ffd', '33c2c7af-640b-4e4b-9682-681fc929d924');


--
-- TOC entry 4230 (class 0 OID 16835)
-- Dependencies: 304
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4231 (class 0 OID 16841)
-- Dependencies: 305
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4232 (class 0 OID 16846)
-- Dependencies: 306
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 4233 (class 0 OID 16851)
-- Dependencies: 307
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.web_origins (client_id, value) VALUES ('21967484-d12e-48b0-8a2d-acc885559c01', '+');
INSERT INTO public.web_origins (client_id, value) VALUES ('78e8963c-3ea0-4eee-b438-237191ebab68', '+');


--
-- TOC entry 3912 (class 2606 OID 16855)
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- TOC entry 3766 (class 2606 OID 16857)
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- TOC entry 3648 (class 2606 OID 16859)
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- TOC entry 3668 (class 2606 OID 16861)
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- TOC entry 3655 (class 2606 OID 16863)
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- TOC entry 3797 (class 2606 OID 16865)
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- TOC entry 3639 (class 2606 OID 16867)
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- TOC entry 3687 (class 2606 OID 16869)
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- TOC entry 3650 (class 2606 OID 16871)
-- Name: client_default_roles constr_client_default_roles; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_default_roles
    ADD CONSTRAINT constr_client_default_roles PRIMARY KEY (client_id, role_id);


--
-- TOC entry 3693 (class 2606 OID 16873)
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- TOC entry 3689 (class 2606 OID 16875)
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- TOC entry 3730 (class 2606 OID 16877)
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- TOC entry 3712 (class 2606 OID 16879)
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- TOC entry 3715 (class 2606 OID 16881)
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- TOC entry 3722 (class 2606 OID 16883)
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- TOC entry 3726 (class 2606 OID 16885)
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- TOC entry 3734 (class 2606 OID 16887)
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- TOC entry 3742 (class 2606 OID 16889)
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- TOC entry 3799 (class 2606 OID 16891)
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- TOC entry 3807 (class 2606 OID 16893)
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- TOC entry 3810 (class 2606 OID 16895)
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- TOC entry 3819 (class 2606 OID 16897)
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- TOC entry 3750 (class 2606 OID 16899)
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- TOC entry 3646 (class 2606 OID 16901)
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- TOC entry 3709 (class 2606 OID 16903)
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- TOC entry 3738 (class 2606 OID 16905)
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- TOC entry 3789 (class 2606 OID 16907)
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- TOC entry 3685 (class 2606 OID 16909)
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- TOC entry 3908 (class 2606 OID 16911)
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- TOC entry 3896 (class 2606 OID 16913)
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- TOC entry 3681 (class 2606 OID 16915)
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- TOC entry 3641 (class 2606 OID 16917)
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- TOC entry 3676 (class 2606 OID 16919)
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- TOC entry 3864 (class 2606 OID 16921)
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- TOC entry 3658 (class 2606 OID 16923)
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- TOC entry 3794 (class 2606 OID 16925)
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- TOC entry 3815 (class 2606 OID 16927)
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- TOC entry 3768 (class 2606 OID 16929)
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- TOC entry 3622 (class 2606 OID 16931)
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- TOC entry 3637 (class 2606 OID 16933)
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- TOC entry 3627 (class 2606 OID 16935)
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- TOC entry 3631 (class 2606 OID 16937)
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- TOC entry 3634 (class 2606 OID 16939)
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- TOC entry 3679 (class 2606 OID 16941)
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- TOC entry 3905 (class 2606 OID 16943)
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- TOC entry 3696 (class 2606 OID 16945)
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- TOC entry 3683 (class 2606 OID 16947)
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- TOC entry 3755 (class 2606 OID 16949)
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- TOC entry 3781 (class 2606 OID 16951)
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- TOC entry 3817 (class 2606 OID 16953)
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- TOC entry 3700 (class 2606 OID 16955)
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- TOC entry 3888 (class 2606 OID 16957)
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- TOC entry 3840 (class 2606 OID 16959)
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- TOC entry 3849 (class 2606 OID 16961)
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- TOC entry 3844 (class 2606 OID 16963)
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- TOC entry 3624 (class 2606 OID 16965)
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- TOC entry 3832 (class 2606 OID 16967)
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- TOC entry 3854 (class 2606 OID 16969)
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- TOC entry 3835 (class 2606 OID 16971)
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- TOC entry 3867 (class 2606 OID 16973)
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- TOC entry 3881 (class 2606 OID 16975)
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- TOC entry 3894 (class 2606 OID 16977)
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- TOC entry 3890 (class 2606 OID 16979)
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- TOC entry 3720 (class 2606 OID 16981)
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- TOC entry 3878 (class 2606 OID 16983)
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- TOC entry 3873 (class 2606 OID 16985)
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- TOC entry 3762 (class 2606 OID 16987)
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- TOC entry 3744 (class 2606 OID 16989)
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3747 (class 2606 OID 16991)
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- TOC entry 3757 (class 2606 OID 16993)
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- TOC entry 3760 (class 2606 OID 16995)
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- TOC entry 3772 (class 2606 OID 16997)
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- TOC entry 3775 (class 2606 OID 16999)
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- TOC entry 3778 (class 2606 OID 17001)
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- TOC entry 3783 (class 2606 OID 17003)
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- TOC entry 3787 (class 2606 OID 17005)
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- TOC entry 3802 (class 2606 OID 17007)
-- Name: realm_default_roles constraint_realm_default_roles; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_default_roles
    ADD CONSTRAINT constraint_realm_default_roles PRIMARY KEY (realm_id, role_id);


--
-- TOC entry 3822 (class 2606 OID 17009)
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- TOC entry 3825 (class 2606 OID 17011)
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- TOC entry 3827 (class 2606 OID 17013)
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- TOC entry 3902 (class 2606 OID 17015)
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- TOC entry 3859 (class 2606 OID 17017)
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- TOC entry 3861 (class 2606 OID 17019)
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3870 (class 2606 OID 17021)
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3899 (class 2606 OID 17023)
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- TOC entry 3910 (class 2606 OID 17025)
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- TOC entry 3914 (class 2606 OID 17027)
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- TOC entry 3666 (class 2606 OID 17029)
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- TOC entry 3661 (class 2606 OID 17031)
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- TOC entry 3703 (class 2606 OID 17033)
-- Name: databasechangeloglock pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- TOC entry 3838 (class 2606 OID 17035)
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- TOC entry 3674 (class 2606 OID 17037)
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- TOC entry 3707 (class 2606 OID 17039)
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- TOC entry 3813 (class 2606 OID 17041)
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- TOC entry 3830 (class 2606 OID 17043)
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- TOC entry 3764 (class 2606 OID 17045)
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- TOC entry 3753 (class 2606 OID 17047)
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- TOC entry 3653 (class 2606 OID 17049)
-- Name: client_default_roles uk_8aelwnibji49avxsrtuf6xjow; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_default_roles
    ADD CONSTRAINT uk_8aelwnibji49avxsrtuf6xjow UNIQUE (role_id);


--
-- TOC entry 3644 (class 2606 OID 17051)
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- TOC entry 3663 (class 2606 OID 17053)
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- TOC entry 3884 (class 2606 OID 17055)
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- TOC entry 3852 (class 2606 OID 17057)
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- TOC entry 3842 (class 2606 OID 17059)
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- TOC entry 3847 (class 2606 OID 17061)
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- TOC entry 3857 (class 2606 OID 17063)
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- TOC entry 3805 (class 2606 OID 17065)
-- Name: realm_default_roles uk_h4wpd7w4hsoolni3h0sw7btje; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_default_roles
    ADD CONSTRAINT uk_h4wpd7w4hsoolni3h0sw7btje UNIQUE (role_id);


--
-- TOC entry 3876 (class 2606 OID 17067)
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- TOC entry 3792 (class 2606 OID 17069)
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- TOC entry 3886 (class 2606 OID 17071)
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- TOC entry 3625 (class 1259 OID 17072)
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- TOC entry 3635 (class 1259 OID 17073)
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- TOC entry 3628 (class 1259 OID 17074)
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- TOC entry 3629 (class 1259 OID 17075)
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- TOC entry 3632 (class 1259 OID 17076)
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- TOC entry 3669 (class 1259 OID 17077)
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- TOC entry 3651 (class 1259 OID 17078)
-- Name: idx_client_def_roles_client; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_client_def_roles_client ON public.client_default_roles USING btree (client_id);


--
-- TOC entry 3642 (class 1259 OID 17079)
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- TOC entry 3656 (class 1259 OID 17080)
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- TOC entry 3677 (class 1259 OID 17081)
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- TOC entry 3664 (class 1259 OID 17082)
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- TOC entry 3670 (class 1259 OID 17083)
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- TOC entry 3784 (class 1259 OID 17084)
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- TOC entry 3671 (class 1259 OID 17085)
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- TOC entry 3694 (class 1259 OID 17086)
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- TOC entry 3690 (class 1259 OID 17087)
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- TOC entry 3691 (class 1259 OID 17088)
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- TOC entry 3697 (class 1259 OID 17089)
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- TOC entry 3698 (class 1259 OID 17090)
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- TOC entry 3704 (class 1259 OID 17091)
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- TOC entry 3705 (class 1259 OID 17092)
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- TOC entry 3710 (class 1259 OID 17093)
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- TOC entry 3739 (class 1259 OID 17094)
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- TOC entry 3740 (class 1259 OID 17095)
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- TOC entry 3713 (class 1259 OID 17096)
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- TOC entry 3716 (class 1259 OID 17097)
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- TOC entry 3717 (class 1259 OID 17098)
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- TOC entry 3718 (class 1259 OID 17099)
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- TOC entry 3723 (class 1259 OID 17100)
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- TOC entry 3724 (class 1259 OID 17101)
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- TOC entry 3727 (class 1259 OID 17102)
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- TOC entry 3728 (class 1259 OID 17103)
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- TOC entry 3731 (class 1259 OID 17104)
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- TOC entry 3732 (class 1259 OID 17105)
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- TOC entry 3735 (class 1259 OID 17106)
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- TOC entry 3736 (class 1259 OID 17107)
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- TOC entry 3745 (class 1259 OID 17108)
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- TOC entry 3748 (class 1259 OID 17109)
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- TOC entry 3758 (class 1259 OID 17110)
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- TOC entry 3751 (class 1259 OID 17111)
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- TOC entry 3769 (class 1259 OID 17112)
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- TOC entry 3770 (class 1259 OID 17113)
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- TOC entry 3779 (class 1259 OID 17114)
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- TOC entry 3785 (class 1259 OID 17115)
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- TOC entry 3795 (class 1259 OID 17116)
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- TOC entry 3659 (class 1259 OID 17117)
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- TOC entry 3800 (class 1259 OID 17118)
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- TOC entry 3803 (class 1259 OID 17119)
-- Name: idx_realm_def_roles_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_realm_def_roles_realm ON public.realm_default_roles USING btree (realm_id);


--
-- TOC entry 3811 (class 1259 OID 17120)
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- TOC entry 3808 (class 1259 OID 17121)
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- TOC entry 3790 (class 1259 OID 17122)
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- TOC entry 3820 (class 1259 OID 17123)
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- TOC entry 3823 (class 1259 OID 17124)
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- TOC entry 3828 (class 1259 OID 17125)
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- TOC entry 3833 (class 1259 OID 17126)
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- TOC entry 3836 (class 1259 OID 17127)
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- TOC entry 3845 (class 1259 OID 17128)
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- TOC entry 3850 (class 1259 OID 17129)
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- TOC entry 3855 (class 1259 OID 17130)
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- TOC entry 3862 (class 1259 OID 17131)
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- TOC entry 3672 (class 1259 OID 17132)
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- TOC entry 3865 (class 1259 OID 17133)
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- TOC entry 3868 (class 1259 OID 17134)
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- TOC entry 3773 (class 1259 OID 17135)
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- TOC entry 3776 (class 1259 OID 17136)
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- TOC entry 3879 (class 1259 OID 17137)
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- TOC entry 3871 (class 1259 OID 17138)
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- TOC entry 3874 (class 1259 OID 17139)
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- TOC entry 3701 (class 1259 OID 17140)
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- TOC entry 3882 (class 1259 OID 17141)
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- TOC entry 3900 (class 1259 OID 17142)
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- TOC entry 3903 (class 1259 OID 17143)
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- TOC entry 3906 (class 1259 OID 17144)
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- TOC entry 3891 (class 1259 OID 17145)
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- TOC entry 3892 (class 1259 OID 17146)
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- TOC entry 3897 (class 1259 OID 17147)
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- TOC entry 3915 (class 1259 OID 17148)
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- TOC entry 3933 (class 2606 OID 17149)
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- TOC entry 3948 (class 2606 OID 17154)
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3923 (class 2606 OID 17159)
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3945 (class 2606 OID 17164)
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3926 (class 2606 OID 17169)
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3934 (class 2606 OID 17174)
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- TOC entry 3996 (class 2606 OID 17179)
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- TOC entry 3936 (class 2606 OID 17184)
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- TOC entry 3966 (class 2606 OID 17189)
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3992 (class 2606 OID 17194)
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3935 (class 2606 OID 17199)
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- TOC entry 3963 (class 2606 OID 17204)
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3968 (class 2606 OID 17209)
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3985 (class 2606 OID 17214)
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3994 (class 2606 OID 17219)
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3953 (class 2606 OID 17224)
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- TOC entry 3964 (class 2606 OID 17229)
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3958 (class 2606 OID 17234)
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3940 (class 2606 OID 17239)
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- TOC entry 3918 (class 2606 OID 17244)
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- TOC entry 3919 (class 2606 OID 17249)
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3920 (class 2606 OID 17254)
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3921 (class 2606 OID 17259)
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3932 (class 2606 OID 17264)
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- TOC entry 3995 (class 2606 OID 17269)
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3929 (class 2606 OID 17274)
-- Name: client_scope_client fk_c_cli_scope_client; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT fk_c_cli_scope_client FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3930 (class 2606 OID 17279)
-- Name: client_scope_client fk_c_cli_scope_scope; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT fk_c_cli_scope_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- TOC entry 3928 (class 2606 OID 17284)
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- TOC entry 3931 (class 2606 OID 17289)
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- TOC entry 3937 (class 2606 OID 17294)
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- TOC entry 3955 (class 2606 OID 17299)
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- TOC entry 3925 (class 2606 OID 17304)
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3939 (class 2606 OID 17309)
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- TOC entry 3938 (class 2606 OID 17314)
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3959 (class 2606 OID 17319)
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3960 (class 2606 OID 17324)
-- Name: realm_default_roles fk_evudb1ppw84oxfax2drs03icc; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_default_roles
    ADD CONSTRAINT fk_evudb1ppw84oxfax2drs03icc FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3991 (class 2606 OID 17329)
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- TOC entry 3989 (class 2606 OID 17334)
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- TOC entry 3990 (class 2606 OID 17339)
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3916 (class 2606 OID 17344)
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3983 (class 2606 OID 17349)
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3973 (class 2606 OID 17354)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3978 (class 2606 OID 17359)
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3974 (class 2606 OID 17364)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3975 (class 2606 OID 17369)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- TOC entry 3917 (class 2606 OID 17374)
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3984 (class 2606 OID 17379)
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- TOC entry 3976 (class 2606 OID 17384)
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3977 (class 2606 OID 17389)
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3971 (class 2606 OID 17394)
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3969 (class 2606 OID 17399)
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3970 (class 2606 OID 17404)
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3972 (class 2606 OID 17409)
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- TOC entry 3979 (class 2606 OID 17414)
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3941 (class 2606 OID 17419)
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- TOC entry 3987 (class 2606 OID 17424)
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- TOC entry 3986 (class 2606 OID 17429)
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3946 (class 2606 OID 17434)
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- TOC entry 3952 (class 2606 OID 17439)
-- Name: keycloak_group fk_group_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT fk_group_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3947 (class 2606 OID 17444)
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- TOC entry 3961 (class 2606 OID 17449)
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3962 (class 2606 OID 17454)
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3950 (class 2606 OID 17459)
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3951 (class 2606 OID 17464)
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- TOC entry 3997 (class 2606 OID 17469)
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3924 (class 2606 OID 17474)
-- Name: client_default_roles fk_nuilts7klwqw2h8m2b5joytky; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_default_roles
    ADD CONSTRAINT fk_nuilts7klwqw2h8m2b5joytky FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3982 (class 2606 OID 17479)
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3922 (class 2606 OID 17484)
-- Name: client fk_p56ctinxxb9gsk57fo49f9tac; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT fk_p56ctinxxb9gsk57fo49f9tac FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3956 (class 2606 OID 17489)
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3942 (class 2606 OID 17494)
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3957 (class 2606 OID 17499)
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- TOC entry 3943 (class 2606 OID 17504)
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3944 (class 2606 OID 17509)
-- Name: default_client_scope fk_r_def_cli_scope_scope; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- TOC entry 3927 (class 2606 OID 17514)
-- Name: client_scope fk_realm_cli_scope; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT fk_realm_cli_scope FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3967 (class 2606 OID 17519)
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3980 (class 2606 OID 17524)
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3981 (class 2606 OID 17529)
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- TOC entry 3965 (class 2606 OID 17534)
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3988 (class 2606 OID 17539)
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- TOC entry 3993 (class 2606 OID 17544)
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3954 (class 2606 OID 17549)
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3949 (class 2606 OID 17554)
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


-- Completed on 2023-05-10 18:55:34 UTC

--
-- PostgreSQL database dump complete
--

