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

--
-- Name: fhir; Type: DATABASE; Schema: -; Owner: fhir
--

CREATE DATABASE fhir WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';


ALTER DATABASE fhir OWNER TO fhir;

\connect fhir

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
-- Name: hfj_binary_storage_blob; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.hfj_binary_storage_blob (
    blob_id character varying(200) NOT NULL,
    blob_data oid NOT NULL,
    content_type character varying(100) NOT NULL,
    blob_hash character varying(128),
    published_date timestamp without time zone NOT NULL,
    resource_id character varying(100) NOT NULL,
    blob_size integer
);


ALTER TABLE public.hfj_binary_storage_blob OWNER TO fhir;

--
-- Name: hfj_blk_export_colfile; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.hfj_blk_export_colfile (
    pid bigint NOT NULL,
    res_id character varying(100) NOT NULL,
    collection_pid bigint NOT NULL
);


ALTER TABLE public.hfj_blk_export_colfile OWNER TO fhir;

--
-- Name: hfj_blk_export_collection; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.hfj_blk_export_collection (
    pid bigint NOT NULL,
    type_filter character varying(1000),
    res_type character varying(40) NOT NULL,
    optlock integer NOT NULL,
    job_pid bigint NOT NULL
);


ALTER TABLE public.hfj_blk_export_collection OWNER TO fhir;

--
-- Name: hfj_blk_export_job; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.hfj_blk_export_job (
    pid bigint NOT NULL,
    created_time timestamp without time zone NOT NULL,
    exp_time timestamp without time zone NOT NULL,
    job_id character varying(36) NOT NULL,
    request character varying(500) NOT NULL,
    exp_since timestamp without time zone,
    job_status character varying(10) NOT NULL,
    status_message character varying(500),
    status_time timestamp without time zone NOT NULL,
    optlock integer NOT NULL
);


ALTER TABLE public.hfj_blk_export_job OWNER TO fhir;

--
-- Name: hfj_forced_id; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.hfj_forced_id (
    pid bigint NOT NULL,
    partition_date date,
    partition_id integer,
    forced_id character varying(100) NOT NULL,
    resource_pid bigint NOT NULL,
    resource_type character varying(100) DEFAULT ''::character varying
);


ALTER TABLE public.hfj_forced_id OWNER TO fhir;

--
-- Name: hfj_history_tag; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.hfj_history_tag (
    pid bigint NOT NULL,
    partition_date date,
    partition_id integer,
    tag_id bigint,
    res_ver_pid bigint NOT NULL,
    res_id bigint NOT NULL,
    res_type character varying(40) NOT NULL
);


ALTER TABLE public.hfj_history_tag OWNER TO fhir;

--
-- Name: hfj_idx_cmp_string_uniq; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.hfj_idx_cmp_string_uniq (
    pid bigint NOT NULL,
    partition_date date,
    partition_id integer,
    idx_string character varying(200) NOT NULL,
    res_id bigint
);


ALTER TABLE public.hfj_idx_cmp_string_uniq OWNER TO fhir;

--
-- Name: hfj_partition; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.hfj_partition (
    part_id integer NOT NULL,
    part_desc character varying(200),
    part_name character varying(200) NOT NULL
);


ALTER TABLE public.hfj_partition OWNER TO fhir;

--
-- Name: hfj_res_link; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.hfj_res_link (
    pid bigint NOT NULL,
    partition_date date,
    partition_id integer,
    src_path character varying(200) NOT NULL,
    src_resource_id bigint NOT NULL,
    source_resource_type character varying(40) NOT NULL,
    target_resource_id bigint,
    target_resource_type character varying(40) NOT NULL,
    target_resource_url character varying(200),
    target_resource_version bigint,
    sp_updated timestamp without time zone
);


ALTER TABLE public.hfj_res_link OWNER TO fhir;

--
-- Name: hfj_res_param_present; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.hfj_res_param_present (
    pid bigint NOT NULL,
    partition_date date,
    partition_id integer,
    hash_presence bigint,
    sp_present boolean NOT NULL,
    res_id bigint NOT NULL
);


ALTER TABLE public.hfj_res_param_present OWNER TO fhir;

--
-- Name: hfj_res_reindex_job; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.hfj_res_reindex_job (
    pid bigint NOT NULL,
    job_deleted boolean NOT NULL,
    reindex_count integer,
    res_type character varying(100),
    suspended_until timestamp without time zone,
    update_threshold_high timestamp without time zone NOT NULL,
    update_threshold_low timestamp without time zone
);


ALTER TABLE public.hfj_res_reindex_job OWNER TO fhir;

--
-- Name: hfj_res_tag; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.hfj_res_tag (
    pid bigint NOT NULL,
    partition_date date,
    partition_id integer,
    tag_id bigint,
    res_id bigint,
    res_type character varying(40) NOT NULL
);


ALTER TABLE public.hfj_res_tag OWNER TO fhir;

--
-- Name: hfj_res_ver; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.hfj_res_ver (
    pid bigint NOT NULL,
    partition_date date,
    partition_id integer,
    res_deleted_at timestamp without time zone,
    res_version character varying(7),
    has_tags boolean NOT NULL,
    res_published timestamp without time zone NOT NULL,
    res_updated timestamp without time zone NOT NULL,
    res_encoding character varying(5) NOT NULL,
    res_text oid,
    res_id bigint NOT NULL,
    res_type character varying(40) NOT NULL,
    res_ver bigint NOT NULL
);


ALTER TABLE public.hfj_res_ver OWNER TO fhir;

--
-- Name: hfj_res_ver_prov; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.hfj_res_ver_prov (
    res_ver_pid bigint NOT NULL,
    partition_date date,
    partition_id integer,
    request_id character varying(16),
    source_uri character varying(100),
    res_pid bigint NOT NULL
);


ALTER TABLE public.hfj_res_ver_prov OWNER TO fhir;

--
-- Name: hfj_resource; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.hfj_resource (
    res_id bigint NOT NULL,
    partition_date date,
    partition_id integer,
    res_deleted_at timestamp without time zone,
    res_version character varying(7),
    has_tags boolean NOT NULL,
    res_published timestamp without time zone NOT NULL,
    res_updated timestamp without time zone NOT NULL,
    sp_has_links boolean,
    hash_sha256 character varying(64),
    sp_index_status bigint,
    res_language character varying(20),
    sp_cmpstr_uniq_present boolean,
    sp_coords_present boolean,
    sp_date_present boolean,
    sp_number_present boolean,
    sp_quantity_nrml_present boolean,
    sp_quantity_present boolean,
    sp_string_present boolean,
    sp_token_present boolean,
    sp_uri_present boolean,
    res_type character varying(40) NOT NULL,
    res_ver bigint
);


ALTER TABLE public.hfj_resource OWNER TO fhir;

--
-- Name: hfj_search; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.hfj_search (
    pid bigint NOT NULL,
    created timestamp without time zone NOT NULL,
    search_deleted boolean,
    expiry_or_null timestamp without time zone,
    failure_code integer,
    failure_message character varying(500),
    last_updated_high timestamp without time zone,
    last_updated_low timestamp without time zone,
    num_blocked integer,
    num_found integer NOT NULL,
    preferred_page_size integer,
    resource_id bigint,
    resource_type character varying(200),
    search_param_map oid,
    search_query_string text,
    search_query_string_hash integer,
    search_type integer NOT NULL,
    search_status character varying(10) NOT NULL,
    total_count integer,
    search_uuid character varying(36) NOT NULL,
    optlock_version integer
);


ALTER TABLE public.hfj_search OWNER TO fhir;

--
-- Name: hfj_search_include; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.hfj_search_include (
    pid bigint NOT NULL,
    search_include character varying(200) NOT NULL,
    inc_recurse boolean NOT NULL,
    revinclude boolean NOT NULL,
    search_pid bigint NOT NULL
);


ALTER TABLE public.hfj_search_include OWNER TO fhir;

--
-- Name: hfj_search_result; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.hfj_search_result (
    pid bigint NOT NULL,
    search_order integer NOT NULL,
    resource_pid bigint NOT NULL,
    search_pid bigint NOT NULL
);


ALTER TABLE public.hfj_search_result OWNER TO fhir;

--
-- Name: hfj_spidx_coords; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.hfj_spidx_coords (
    sp_id bigint NOT NULL,
    partition_date date,
    partition_id integer,
    sp_missing boolean NOT NULL,
    sp_name character varying(100) NOT NULL,
    res_id bigint NOT NULL,
    res_type character varying(100) NOT NULL,
    sp_updated timestamp without time zone,
    hash_identity bigint,
    sp_latitude double precision,
    sp_longitude double precision
);


ALTER TABLE public.hfj_spidx_coords OWNER TO fhir;

--
-- Name: hfj_spidx_date; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.hfj_spidx_date (
    sp_id bigint NOT NULL,
    partition_date date,
    partition_id integer,
    sp_missing boolean NOT NULL,
    sp_name character varying(100) NOT NULL,
    res_id bigint NOT NULL,
    res_type character varying(100) NOT NULL,
    sp_updated timestamp without time zone,
    hash_identity bigint,
    sp_value_high timestamp without time zone,
    sp_value_high_date_ordinal integer,
    sp_value_low timestamp without time zone,
    sp_value_low_date_ordinal integer
);


ALTER TABLE public.hfj_spidx_date OWNER TO fhir;

--
-- Name: hfj_spidx_number; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.hfj_spidx_number (
    sp_id bigint NOT NULL,
    partition_date date,
    partition_id integer,
    sp_missing boolean NOT NULL,
    sp_name character varying(100) NOT NULL,
    res_id bigint NOT NULL,
    res_type character varying(100) NOT NULL,
    sp_updated timestamp without time zone,
    hash_identity bigint,
    sp_value numeric(19,2)
);


ALTER TABLE public.hfj_spidx_number OWNER TO fhir;

--
-- Name: hfj_spidx_quantity; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.hfj_spidx_quantity (
    sp_id bigint NOT NULL,
    partition_date date,
    partition_id integer,
    sp_missing boolean NOT NULL,
    sp_name character varying(100) NOT NULL,
    res_id bigint NOT NULL,
    res_type character varying(100) NOT NULL,
    sp_updated timestamp without time zone,
    hash_identity bigint,
    hash_identity_and_units bigint,
    hash_identity_sys_units bigint,
    sp_system character varying(200),
    sp_units character varying(200),
    sp_value double precision
);


ALTER TABLE public.hfj_spidx_quantity OWNER TO fhir;

--
-- Name: hfj_spidx_quantity_nrml; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.hfj_spidx_quantity_nrml (
    sp_id bigint NOT NULL,
    partition_date date,
    partition_id integer,
    sp_missing boolean NOT NULL,
    sp_name character varying(100) NOT NULL,
    res_id bigint NOT NULL,
    res_type character varying(100) NOT NULL,
    sp_updated timestamp without time zone,
    hash_identity bigint,
    hash_identity_and_units bigint,
    hash_identity_sys_units bigint,
    sp_system character varying(200),
    sp_units character varying(200),
    sp_value double precision
);


ALTER TABLE public.hfj_spidx_quantity_nrml OWNER TO fhir;

--
-- Name: hfj_spidx_string; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.hfj_spidx_string (
    sp_id bigint NOT NULL,
    partition_date date,
    partition_id integer,
    sp_missing boolean NOT NULL,
    sp_name character varying(100) NOT NULL,
    res_id bigint NOT NULL,
    res_type character varying(100) NOT NULL,
    sp_updated timestamp without time zone,
    hash_exact bigint,
    hash_identity bigint,
    hash_norm_prefix bigint,
    sp_value_exact character varying(200),
    sp_value_normalized character varying(200)
);


ALTER TABLE public.hfj_spidx_string OWNER TO fhir;

--
-- Name: hfj_spidx_token; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.hfj_spidx_token (
    sp_id bigint NOT NULL,
    partition_date date,
    partition_id integer,
    sp_missing boolean NOT NULL,
    sp_name character varying(100) NOT NULL,
    res_id bigint NOT NULL,
    res_type character varying(100) NOT NULL,
    sp_updated timestamp without time zone,
    hash_identity bigint,
    hash_sys bigint,
    hash_sys_and_value bigint,
    hash_value bigint,
    sp_system character varying(200),
    sp_value character varying(200)
);


ALTER TABLE public.hfj_spidx_token OWNER TO fhir;

--
-- Name: hfj_spidx_uri; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.hfj_spidx_uri (
    sp_id bigint NOT NULL,
    partition_date date,
    partition_id integer,
    sp_missing boolean NOT NULL,
    sp_name character varying(100) NOT NULL,
    res_id bigint NOT NULL,
    res_type character varying(100) NOT NULL,
    sp_updated timestamp without time zone,
    hash_identity bigint,
    hash_uri bigint,
    sp_uri character varying(254)
);


ALTER TABLE public.hfj_spidx_uri OWNER TO fhir;

--
-- Name: hfj_subscription_stats; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.hfj_subscription_stats (
    pid bigint NOT NULL,
    created_time timestamp without time zone NOT NULL,
    res_id bigint
);


ALTER TABLE public.hfj_subscription_stats OWNER TO fhir;

--
-- Name: hfj_tag_def; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.hfj_tag_def (
    tag_id bigint NOT NULL,
    tag_code character varying(200),
    tag_display character varying(200),
    tag_system character varying(200),
    tag_type integer NOT NULL
);


ALTER TABLE public.hfj_tag_def OWNER TO fhir;

--
-- Name: mpi_link; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.mpi_link (
    pid bigint NOT NULL,
    created timestamp without time zone NOT NULL,
    eid_match boolean,
    golden_resource_pid bigint NOT NULL,
    new_person boolean,
    link_source integer NOT NULL,
    match_result integer NOT NULL,
    target_type character varying(40),
    person_pid bigint NOT NULL,
    rule_count bigint,
    score double precision,
    target_pid bigint NOT NULL,
    updated timestamp without time zone NOT NULL,
    vector bigint,
    version character varying(16) NOT NULL
);


ALTER TABLE public.mpi_link OWNER TO fhir;

--
-- Name: npm_package; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.npm_package (
    pid bigint NOT NULL,
    cur_version_id character varying(200),
    package_desc character varying(200),
    package_id character varying(200) NOT NULL,
    updated_time timestamp without time zone NOT NULL
);


ALTER TABLE public.npm_package OWNER TO fhir;

--
-- Name: npm_package_ver; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.npm_package_ver (
    pid bigint NOT NULL,
    current_version boolean NOT NULL,
    pkg_desc character varying(200),
    desc_upper character varying(200),
    fhir_version character varying(10) NOT NULL,
    fhir_version_id character varying(10) NOT NULL,
    package_id character varying(200) NOT NULL,
    package_size_bytes bigint NOT NULL,
    saved_time timestamp without time zone NOT NULL,
    updated_time timestamp without time zone NOT NULL,
    version_id character varying(200) NOT NULL,
    package_pid bigint NOT NULL,
    binary_res_id bigint NOT NULL
);


ALTER TABLE public.npm_package_ver OWNER TO fhir;

--
-- Name: npm_package_ver_res; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.npm_package_ver_res (
    pid bigint NOT NULL,
    canonical_url character varying(200),
    canonical_version character varying(200),
    file_dir character varying(200),
    fhir_version character varying(10) NOT NULL,
    fhir_version_id character varying(10) NOT NULL,
    file_name character varying(200),
    res_size_bytes bigint NOT NULL,
    res_type character varying(40) NOT NULL,
    updated_time timestamp without time zone NOT NULL,
    packver_pid bigint NOT NULL,
    binary_res_id bigint NOT NULL
);


ALTER TABLE public.npm_package_ver_res OWNER TO fhir;

--
-- Name: seq_blkexcol_pid; Type: SEQUENCE; Schema: public; Owner: fhir
--

CREATE SEQUENCE public.seq_blkexcol_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_blkexcol_pid OWNER TO fhir;

--
-- Name: seq_blkexcolfile_pid; Type: SEQUENCE; Schema: public; Owner: fhir
--

CREATE SEQUENCE public.seq_blkexcolfile_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_blkexcolfile_pid OWNER TO fhir;

--
-- Name: seq_blkexjob_pid; Type: SEQUENCE; Schema: public; Owner: fhir
--

CREATE SEQUENCE public.seq_blkexjob_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_blkexjob_pid OWNER TO fhir;

--
-- Name: seq_cncpt_map_grp_elm_tgt_pid; Type: SEQUENCE; Schema: public; Owner: fhir
--

CREATE SEQUENCE public.seq_cncpt_map_grp_elm_tgt_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_cncpt_map_grp_elm_tgt_pid OWNER TO fhir;

--
-- Name: seq_codesystem_pid; Type: SEQUENCE; Schema: public; Owner: fhir
--

CREATE SEQUENCE public.seq_codesystem_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_codesystem_pid OWNER TO fhir;

--
-- Name: seq_codesystemver_pid; Type: SEQUENCE; Schema: public; Owner: fhir
--

CREATE SEQUENCE public.seq_codesystemver_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_codesystemver_pid OWNER TO fhir;

--
-- Name: seq_concept_desig_pid; Type: SEQUENCE; Schema: public; Owner: fhir
--

CREATE SEQUENCE public.seq_concept_desig_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_concept_desig_pid OWNER TO fhir;

--
-- Name: seq_concept_map_group_pid; Type: SEQUENCE; Schema: public; Owner: fhir
--

CREATE SEQUENCE public.seq_concept_map_group_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_concept_map_group_pid OWNER TO fhir;

--
-- Name: seq_concept_map_grp_elm_pid; Type: SEQUENCE; Schema: public; Owner: fhir
--

CREATE SEQUENCE public.seq_concept_map_grp_elm_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_concept_map_grp_elm_pid OWNER TO fhir;

--
-- Name: seq_concept_map_pid; Type: SEQUENCE; Schema: public; Owner: fhir
--

CREATE SEQUENCE public.seq_concept_map_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_concept_map_pid OWNER TO fhir;

--
-- Name: seq_concept_pc_pid; Type: SEQUENCE; Schema: public; Owner: fhir
--

CREATE SEQUENCE public.seq_concept_pc_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_concept_pc_pid OWNER TO fhir;

--
-- Name: seq_concept_pid; Type: SEQUENCE; Schema: public; Owner: fhir
--

CREATE SEQUENCE public.seq_concept_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_concept_pid OWNER TO fhir;

--
-- Name: seq_concept_prop_pid; Type: SEQUENCE; Schema: public; Owner: fhir
--

CREATE SEQUENCE public.seq_concept_prop_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_concept_prop_pid OWNER TO fhir;

--
-- Name: seq_empi_link_id; Type: SEQUENCE; Schema: public; Owner: fhir
--

CREATE SEQUENCE public.seq_empi_link_id
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_empi_link_id OWNER TO fhir;

--
-- Name: seq_forcedid_id; Type: SEQUENCE; Schema: public; Owner: fhir
--

CREATE SEQUENCE public.seq_forcedid_id
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_forcedid_id OWNER TO fhir;

--
-- Name: seq_historytag_id; Type: SEQUENCE; Schema: public; Owner: fhir
--

CREATE SEQUENCE public.seq_historytag_id
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_historytag_id OWNER TO fhir;

--
-- Name: seq_idxcmpstruniq_id; Type: SEQUENCE; Schema: public; Owner: fhir
--

CREATE SEQUENCE public.seq_idxcmpstruniq_id
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_idxcmpstruniq_id OWNER TO fhir;

--
-- Name: seq_npm_pack; Type: SEQUENCE; Schema: public; Owner: fhir
--

CREATE SEQUENCE public.seq_npm_pack
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_npm_pack OWNER TO fhir;

--
-- Name: seq_npm_packver; Type: SEQUENCE; Schema: public; Owner: fhir
--

CREATE SEQUENCE public.seq_npm_packver
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_npm_packver OWNER TO fhir;

--
-- Name: seq_npm_packverres; Type: SEQUENCE; Schema: public; Owner: fhir
--

CREATE SEQUENCE public.seq_npm_packverres
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_npm_packverres OWNER TO fhir;

--
-- Name: seq_res_reindex_job; Type: SEQUENCE; Schema: public; Owner: fhir
--

CREATE SEQUENCE public.seq_res_reindex_job
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_res_reindex_job OWNER TO fhir;

--
-- Name: seq_reslink_id; Type: SEQUENCE; Schema: public; Owner: fhir
--

CREATE SEQUENCE public.seq_reslink_id
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_reslink_id OWNER TO fhir;

--
-- Name: seq_resource_history_id; Type: SEQUENCE; Schema: public; Owner: fhir
--

CREATE SEQUENCE public.seq_resource_history_id
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_resource_history_id OWNER TO fhir;

--
-- Name: seq_resource_id; Type: SEQUENCE; Schema: public; Owner: fhir
--

CREATE SEQUENCE public.seq_resource_id
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_resource_id OWNER TO fhir;

--
-- Name: seq_resparmpresent_id; Type: SEQUENCE; Schema: public; Owner: fhir
--

CREATE SEQUENCE public.seq_resparmpresent_id
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_resparmpresent_id OWNER TO fhir;

--
-- Name: seq_restag_id; Type: SEQUENCE; Schema: public; Owner: fhir
--

CREATE SEQUENCE public.seq_restag_id
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_restag_id OWNER TO fhir;

--
-- Name: seq_search; Type: SEQUENCE; Schema: public; Owner: fhir
--

CREATE SEQUENCE public.seq_search
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_search OWNER TO fhir;

--
-- Name: seq_search_inc; Type: SEQUENCE; Schema: public; Owner: fhir
--

CREATE SEQUENCE public.seq_search_inc
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_search_inc OWNER TO fhir;

--
-- Name: seq_search_res; Type: SEQUENCE; Schema: public; Owner: fhir
--

CREATE SEQUENCE public.seq_search_res
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_search_res OWNER TO fhir;

--
-- Name: seq_spidx_coords; Type: SEQUENCE; Schema: public; Owner: fhir
--

CREATE SEQUENCE public.seq_spidx_coords
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_spidx_coords OWNER TO fhir;

--
-- Name: seq_spidx_date; Type: SEQUENCE; Schema: public; Owner: fhir
--

CREATE SEQUENCE public.seq_spidx_date
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_spidx_date OWNER TO fhir;

--
-- Name: seq_spidx_number; Type: SEQUENCE; Schema: public; Owner: fhir
--

CREATE SEQUENCE public.seq_spidx_number
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_spidx_number OWNER TO fhir;

--
-- Name: seq_spidx_quantity; Type: SEQUENCE; Schema: public; Owner: fhir
--

CREATE SEQUENCE public.seq_spidx_quantity
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_spidx_quantity OWNER TO fhir;

--
-- Name: seq_spidx_quantity_nrml; Type: SEQUENCE; Schema: public; Owner: fhir
--

CREATE SEQUENCE public.seq_spidx_quantity_nrml
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_spidx_quantity_nrml OWNER TO fhir;

--
-- Name: seq_spidx_string; Type: SEQUENCE; Schema: public; Owner: fhir
--

CREATE SEQUENCE public.seq_spidx_string
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_spidx_string OWNER TO fhir;

--
-- Name: seq_spidx_token; Type: SEQUENCE; Schema: public; Owner: fhir
--

CREATE SEQUENCE public.seq_spidx_token
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_spidx_token OWNER TO fhir;

--
-- Name: seq_spidx_uri; Type: SEQUENCE; Schema: public; Owner: fhir
--

CREATE SEQUENCE public.seq_spidx_uri
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_spidx_uri OWNER TO fhir;

--
-- Name: seq_subscription_id; Type: SEQUENCE; Schema: public; Owner: fhir
--

CREATE SEQUENCE public.seq_subscription_id
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_subscription_id OWNER TO fhir;

--
-- Name: seq_tagdef_id; Type: SEQUENCE; Schema: public; Owner: fhir
--

CREATE SEQUENCE public.seq_tagdef_id
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_tagdef_id OWNER TO fhir;

--
-- Name: seq_valueset_c_dsgntn_pid; Type: SEQUENCE; Schema: public; Owner: fhir
--

CREATE SEQUENCE public.seq_valueset_c_dsgntn_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_valueset_c_dsgntn_pid OWNER TO fhir;

--
-- Name: seq_valueset_concept_pid; Type: SEQUENCE; Schema: public; Owner: fhir
--

CREATE SEQUENCE public.seq_valueset_concept_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_valueset_concept_pid OWNER TO fhir;

--
-- Name: seq_valueset_pid; Type: SEQUENCE; Schema: public; Owner: fhir
--

CREATE SEQUENCE public.seq_valueset_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_valueset_pid OWNER TO fhir;

--
-- Name: trm_codesystem; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.trm_codesystem (
    pid bigint NOT NULL,
    code_system_uri character varying(200) NOT NULL,
    current_version_pid bigint,
    cs_name character varying(200),
    res_id bigint
);


ALTER TABLE public.trm_codesystem OWNER TO fhir;

--
-- Name: trm_codesystem_ver; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.trm_codesystem_ver (
    pid bigint NOT NULL,
    cs_display character varying(200),
    codesystem_pid bigint,
    cs_version_id character varying(200),
    res_id bigint NOT NULL
);


ALTER TABLE public.trm_codesystem_ver OWNER TO fhir;

--
-- Name: trm_concept; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.trm_concept (
    pid bigint NOT NULL,
    codeval character varying(500) NOT NULL,
    codesystem_pid bigint,
    display character varying(400),
    index_status bigint,
    parent_pids text,
    code_sequence integer,
    concept_updated timestamp without time zone
);


ALTER TABLE public.trm_concept OWNER TO fhir;

--
-- Name: trm_concept_desig; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.trm_concept_desig (
    pid bigint NOT NULL,
    lang character varying(500),
    use_code character varying(500),
    use_display character varying(500),
    use_system character varying(500),
    val character varying(2000) NOT NULL,
    cs_ver_pid bigint,
    concept_pid bigint
);


ALTER TABLE public.trm_concept_desig OWNER TO fhir;

--
-- Name: trm_concept_map; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.trm_concept_map (
    pid bigint NOT NULL,
    res_id bigint,
    source_url character varying(200),
    target_url character varying(200),
    url character varying(200) NOT NULL,
    ver character varying(200)
);


ALTER TABLE public.trm_concept_map OWNER TO fhir;

--
-- Name: trm_concept_map_group; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.trm_concept_map_group (
    pid bigint NOT NULL,
    concept_map_url character varying(200),
    source_url character varying(200) NOT NULL,
    source_vs character varying(200),
    source_version character varying(200),
    target_url character varying(200) NOT NULL,
    target_vs character varying(200),
    target_version character varying(200),
    concept_map_pid bigint NOT NULL
);


ALTER TABLE public.trm_concept_map_group OWNER TO fhir;

--
-- Name: trm_concept_map_grp_element; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.trm_concept_map_grp_element (
    pid bigint NOT NULL,
    source_code character varying(500) NOT NULL,
    concept_map_url character varying(200),
    source_display character varying(400),
    system_url character varying(200),
    system_version character varying(200),
    valueset_url character varying(200),
    concept_map_group_pid bigint NOT NULL
);


ALTER TABLE public.trm_concept_map_grp_element OWNER TO fhir;

--
-- Name: trm_concept_map_grp_elm_tgt; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.trm_concept_map_grp_elm_tgt (
    pid bigint NOT NULL,
    target_code character varying(500) NOT NULL,
    concept_map_url character varying(200),
    target_display character varying(400),
    target_equivalence character varying(50),
    system_url character varying(200),
    system_version character varying(200),
    valueset_url character varying(200),
    concept_map_grp_elm_pid bigint NOT NULL
);


ALTER TABLE public.trm_concept_map_grp_elm_tgt OWNER TO fhir;

--
-- Name: trm_concept_pc_link; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.trm_concept_pc_link (
    pid bigint NOT NULL,
    child_pid bigint,
    codesystem_pid bigint NOT NULL,
    parent_pid bigint,
    rel_type integer
);


ALTER TABLE public.trm_concept_pc_link OWNER TO fhir;

--
-- Name: trm_concept_property; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.trm_concept_property (
    pid bigint NOT NULL,
    prop_codesystem character varying(500),
    prop_display character varying(500),
    prop_key character varying(500) NOT NULL,
    prop_type integer NOT NULL,
    prop_val character varying(500),
    prop_val_lob oid,
    cs_ver_pid bigint,
    concept_pid bigint
);


ALTER TABLE public.trm_concept_property OWNER TO fhir;

--
-- Name: trm_valueset; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.trm_valueset (
    pid bigint NOT NULL,
    expansion_status character varying(50) NOT NULL,
    vsname character varying(200),
    res_id bigint,
    total_concept_designations bigint DEFAULT 0 NOT NULL,
    total_concepts bigint DEFAULT 0 NOT NULL,
    url character varying(200) NOT NULL,
    ver character varying(200)
);


ALTER TABLE public.trm_valueset OWNER TO fhir;

--
-- Name: trm_valueset_c_designation; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.trm_valueset_c_designation (
    pid bigint NOT NULL,
    valueset_concept_pid bigint NOT NULL,
    lang character varying(500),
    use_code character varying(500),
    use_display character varying(500),
    use_system character varying(500),
    val character varying(2000) NOT NULL,
    valueset_pid bigint NOT NULL
);


ALTER TABLE public.trm_valueset_c_designation OWNER TO fhir;

--
-- Name: trm_valueset_concept; Type: TABLE; Schema: public; Owner: fhir
--

CREATE TABLE public.trm_valueset_concept (
    pid bigint NOT NULL,
    codeval character varying(500) NOT NULL,
    display character varying(400),
    valueset_order integer NOT NULL,
    system_url character varying(200) NOT NULL,
    system_ver character varying(200),
    valueset_pid bigint NOT NULL
);


ALTER TABLE public.trm_valueset_concept OWNER TO fhir;

--
-- Data for Name: hfj_binary_storage_blob; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.hfj_binary_storage_blob (blob_id, blob_data, content_type, blob_hash, published_date, resource_id, blob_size) FROM stdin;
\.


--
-- Data for Name: hfj_blk_export_colfile; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.hfj_blk_export_colfile (pid, res_id, collection_pid) FROM stdin;
\.


--
-- Data for Name: hfj_blk_export_collection; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.hfj_blk_export_collection (pid, type_filter, res_type, optlock, job_pid) FROM stdin;
\.


--
-- Data for Name: hfj_blk_export_job; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.hfj_blk_export_job (pid, created_time, exp_time, job_id, request, exp_since, job_status, status_message, status_time, optlock) FROM stdin;
\.


--
-- Data for Name: hfj_forced_id; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.hfj_forced_id (pid, partition_date, partition_id, forced_id, resource_pid, resource_type) FROM stdin;
\.


--
-- Data for Name: hfj_history_tag; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.hfj_history_tag (pid, partition_date, partition_id, tag_id, res_ver_pid, res_id, res_type) FROM stdin;
\.


--
-- Data for Name: hfj_idx_cmp_string_uniq; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.hfj_idx_cmp_string_uniq (pid, partition_date, partition_id, idx_string, res_id) FROM stdin;
\.


--
-- Data for Name: hfj_partition; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.hfj_partition (part_id, part_desc, part_name) FROM stdin;
\.


--
-- Data for Name: hfj_res_link; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.hfj_res_link (pid, partition_date, partition_id, src_path, src_resource_id, source_resource_type, target_resource_id, target_resource_type, target_resource_url, target_resource_version, sp_updated) FROM stdin;
\.


--
-- Data for Name: hfj_res_param_present; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.hfj_res_param_present (pid, partition_date, partition_id, hash_presence, sp_present, res_id) FROM stdin;
\.


--
-- Data for Name: hfj_res_reindex_job; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.hfj_res_reindex_job (pid, job_deleted, reindex_count, res_type, suspended_until, update_threshold_high, update_threshold_low) FROM stdin;
\.


--
-- Data for Name: hfj_res_tag; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.hfj_res_tag (pid, partition_date, partition_id, tag_id, res_id, res_type) FROM stdin;
\.


--
-- Data for Name: hfj_res_ver; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.hfj_res_ver (pid, partition_date, partition_id, res_deleted_at, res_version, has_tags, res_published, res_updated, res_encoding, res_text, res_id, res_type, res_ver) FROM stdin;
\.


--
-- Data for Name: hfj_res_ver_prov; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.hfj_res_ver_prov (res_ver_pid, partition_date, partition_id, request_id, source_uri, res_pid) FROM stdin;
\.


--
-- Data for Name: hfj_resource; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.hfj_resource (res_id, partition_date, partition_id, res_deleted_at, res_version, has_tags, res_published, res_updated, sp_has_links, hash_sha256, sp_index_status, res_language, sp_cmpstr_uniq_present, sp_coords_present, sp_date_present, sp_number_present, sp_quantity_nrml_present, sp_quantity_present, sp_string_present, sp_token_present, sp_uri_present, res_type, res_ver) FROM stdin;
\.


--
-- Data for Name: hfj_search; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.hfj_search (pid, created, search_deleted, expiry_or_null, failure_code, failure_message, last_updated_high, last_updated_low, num_blocked, num_found, preferred_page_size, resource_id, resource_type, search_param_map, search_query_string, search_query_string_hash, search_type, search_status, total_count, search_uuid, optlock_version) FROM stdin;
\.


--
-- Data for Name: hfj_search_include; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.hfj_search_include (pid, search_include, inc_recurse, revinclude, search_pid) FROM stdin;
\.


--
-- Data for Name: hfj_search_result; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.hfj_search_result (pid, search_order, resource_pid, search_pid) FROM stdin;
\.


--
-- Data for Name: hfj_spidx_coords; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.hfj_spidx_coords (sp_id, partition_date, partition_id, sp_missing, sp_name, res_id, res_type, sp_updated, hash_identity, sp_latitude, sp_longitude) FROM stdin;
\.


--
-- Data for Name: hfj_spidx_date; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.hfj_spidx_date (sp_id, partition_date, partition_id, sp_missing, sp_name, res_id, res_type, sp_updated, hash_identity, sp_value_high, sp_value_high_date_ordinal, sp_value_low, sp_value_low_date_ordinal) FROM stdin;
\.


--
-- Data for Name: hfj_spidx_number; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.hfj_spidx_number (sp_id, partition_date, partition_id, sp_missing, sp_name, res_id, res_type, sp_updated, hash_identity, sp_value) FROM stdin;
\.


--
-- Data for Name: hfj_spidx_quantity; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.hfj_spidx_quantity (sp_id, partition_date, partition_id, sp_missing, sp_name, res_id, res_type, sp_updated, hash_identity, hash_identity_and_units, hash_identity_sys_units, sp_system, sp_units, sp_value) FROM stdin;
\.


--
-- Data for Name: hfj_spidx_quantity_nrml; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.hfj_spidx_quantity_nrml (sp_id, partition_date, partition_id, sp_missing, sp_name, res_id, res_type, sp_updated, hash_identity, hash_identity_and_units, hash_identity_sys_units, sp_system, sp_units, sp_value) FROM stdin;
\.


--
-- Data for Name: hfj_spidx_string; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.hfj_spidx_string (sp_id, partition_date, partition_id, sp_missing, sp_name, res_id, res_type, sp_updated, hash_exact, hash_identity, hash_norm_prefix, sp_value_exact, sp_value_normalized) FROM stdin;
\.


--
-- Data for Name: hfj_spidx_token; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.hfj_spidx_token (sp_id, partition_date, partition_id, sp_missing, sp_name, res_id, res_type, sp_updated, hash_identity, hash_sys, hash_sys_and_value, hash_value, sp_system, sp_value) FROM stdin;
\.


--
-- Data for Name: hfj_spidx_uri; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.hfj_spidx_uri (sp_id, partition_date, partition_id, sp_missing, sp_name, res_id, res_type, sp_updated, hash_identity, hash_uri, sp_uri) FROM stdin;
\.


--
-- Data for Name: hfj_subscription_stats; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.hfj_subscription_stats (pid, created_time, res_id) FROM stdin;
\.


--
-- Data for Name: hfj_tag_def; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.hfj_tag_def (tag_id, tag_code, tag_display, tag_system, tag_type) FROM stdin;
\.


--
-- Data for Name: mpi_link; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.mpi_link (pid, created, eid_match, golden_resource_pid, new_person, link_source, match_result, target_type, person_pid, rule_count, score, target_pid, updated, vector, version) FROM stdin;
\.


--
-- Data for Name: npm_package; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.npm_package (pid, cur_version_id, package_desc, package_id, updated_time) FROM stdin;
\.


--
-- Data for Name: npm_package_ver; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.npm_package_ver (pid, current_version, pkg_desc, desc_upper, fhir_version, fhir_version_id, package_id, package_size_bytes, saved_time, updated_time, version_id, package_pid, binary_res_id) FROM stdin;
\.


--
-- Data for Name: npm_package_ver_res; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.npm_package_ver_res (pid, canonical_url, canonical_version, file_dir, fhir_version, fhir_version_id, file_name, res_size_bytes, res_type, updated_time, packver_pid, binary_res_id) FROM stdin;
\.


--
-- Data for Name: trm_codesystem; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.trm_codesystem (pid, code_system_uri, current_version_pid, cs_name, res_id) FROM stdin;
\.


--
-- Data for Name: trm_codesystem_ver; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.trm_codesystem_ver (pid, cs_display, codesystem_pid, cs_version_id, res_id) FROM stdin;
\.


--
-- Data for Name: trm_concept; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.trm_concept (pid, codeval, codesystem_pid, display, index_status, parent_pids, code_sequence, concept_updated) FROM stdin;
\.


--
-- Data for Name: trm_concept_desig; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.trm_concept_desig (pid, lang, use_code, use_display, use_system, val, cs_ver_pid, concept_pid) FROM stdin;
\.


--
-- Data for Name: trm_concept_map; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.trm_concept_map (pid, res_id, source_url, target_url, url, ver) FROM stdin;
\.


--
-- Data for Name: trm_concept_map_group; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.trm_concept_map_group (pid, concept_map_url, source_url, source_vs, source_version, target_url, target_vs, target_version, concept_map_pid) FROM stdin;
\.


--
-- Data for Name: trm_concept_map_grp_element; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.trm_concept_map_grp_element (pid, source_code, concept_map_url, source_display, system_url, system_version, valueset_url, concept_map_group_pid) FROM stdin;
\.


--
-- Data for Name: trm_concept_map_grp_elm_tgt; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.trm_concept_map_grp_elm_tgt (pid, target_code, concept_map_url, target_display, target_equivalence, system_url, system_version, valueset_url, concept_map_grp_elm_pid) FROM stdin;
\.


--
-- Data for Name: trm_concept_pc_link; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.trm_concept_pc_link (pid, child_pid, codesystem_pid, parent_pid, rel_type) FROM stdin;
\.


--
-- Data for Name: trm_concept_property; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.trm_concept_property (pid, prop_codesystem, prop_display, prop_key, prop_type, prop_val, prop_val_lob, cs_ver_pid, concept_pid) FROM stdin;
\.


--
-- Data for Name: trm_valueset; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.trm_valueset (pid, expansion_status, vsname, res_id, total_concept_designations, total_concepts, url, ver) FROM stdin;
\.


--
-- Data for Name: trm_valueset_c_designation; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.trm_valueset_c_designation (pid, valueset_concept_pid, lang, use_code, use_display, use_system, val, valueset_pid) FROM stdin;
\.


--
-- Data for Name: trm_valueset_concept; Type: TABLE DATA; Schema: public; Owner: fhir
--

COPY public.trm_valueset_concept (pid, codeval, display, valueset_order, system_url, system_ver, valueset_pid) FROM stdin;
\.


--
-- Name: seq_blkexcol_pid; Type: SEQUENCE SET; Schema: public; Owner: fhir
--

SELECT pg_catalog.setval('public.seq_blkexcol_pid', 1, false);


--
-- Name: seq_blkexcolfile_pid; Type: SEQUENCE SET; Schema: public; Owner: fhir
--

SELECT pg_catalog.setval('public.seq_blkexcolfile_pid', 1, false);


--
-- Name: seq_blkexjob_pid; Type: SEQUENCE SET; Schema: public; Owner: fhir
--

SELECT pg_catalog.setval('public.seq_blkexjob_pid', 1, false);


--
-- Name: seq_cncpt_map_grp_elm_tgt_pid; Type: SEQUENCE SET; Schema: public; Owner: fhir
--

SELECT pg_catalog.setval('public.seq_cncpt_map_grp_elm_tgt_pid', 1, false);


--
-- Name: seq_codesystem_pid; Type: SEQUENCE SET; Schema: public; Owner: fhir
--

SELECT pg_catalog.setval('public.seq_codesystem_pid', 1, false);


--
-- Name: seq_codesystemver_pid; Type: SEQUENCE SET; Schema: public; Owner: fhir
--

SELECT pg_catalog.setval('public.seq_codesystemver_pid', 1, false);


--
-- Name: seq_concept_desig_pid; Type: SEQUENCE SET; Schema: public; Owner: fhir
--

SELECT pg_catalog.setval('public.seq_concept_desig_pid', 1, false);


--
-- Name: seq_concept_map_group_pid; Type: SEQUENCE SET; Schema: public; Owner: fhir
--

SELECT pg_catalog.setval('public.seq_concept_map_group_pid', 1, false);


--
-- Name: seq_concept_map_grp_elm_pid; Type: SEQUENCE SET; Schema: public; Owner: fhir
--

SELECT pg_catalog.setval('public.seq_concept_map_grp_elm_pid', 1, false);


--
-- Name: seq_concept_map_pid; Type: SEQUENCE SET; Schema: public; Owner: fhir
--

SELECT pg_catalog.setval('public.seq_concept_map_pid', 1, false);


--
-- Name: seq_concept_pc_pid; Type: SEQUENCE SET; Schema: public; Owner: fhir
--

SELECT pg_catalog.setval('public.seq_concept_pc_pid', 1, false);


--
-- Name: seq_concept_pid; Type: SEQUENCE SET; Schema: public; Owner: fhir
--

SELECT pg_catalog.setval('public.seq_concept_pid', 1, false);


--
-- Name: seq_concept_prop_pid; Type: SEQUENCE SET; Schema: public; Owner: fhir
--

SELECT pg_catalog.setval('public.seq_concept_prop_pid', 1, false);


--
-- Name: seq_empi_link_id; Type: SEQUENCE SET; Schema: public; Owner: fhir
--

SELECT pg_catalog.setval('public.seq_empi_link_id', 1, false);


--
-- Name: seq_forcedid_id; Type: SEQUENCE SET; Schema: public; Owner: fhir
--

SELECT pg_catalog.setval('public.seq_forcedid_id', 1, false);


--
-- Name: seq_historytag_id; Type: SEQUENCE SET; Schema: public; Owner: fhir
--

SELECT pg_catalog.setval('public.seq_historytag_id', 1, false);


--
-- Name: seq_idxcmpstruniq_id; Type: SEQUENCE SET; Schema: public; Owner: fhir
--

SELECT pg_catalog.setval('public.seq_idxcmpstruniq_id', 1, false);


--
-- Name: seq_npm_pack; Type: SEQUENCE SET; Schema: public; Owner: fhir
--

SELECT pg_catalog.setval('public.seq_npm_pack', 1, false);


--
-- Name: seq_npm_packver; Type: SEQUENCE SET; Schema: public; Owner: fhir
--

SELECT pg_catalog.setval('public.seq_npm_packver', 1, false);


--
-- Name: seq_npm_packverres; Type: SEQUENCE SET; Schema: public; Owner: fhir
--

SELECT pg_catalog.setval('public.seq_npm_packverres', 1, false);


--
-- Name: seq_res_reindex_job; Type: SEQUENCE SET; Schema: public; Owner: fhir
--

SELECT pg_catalog.setval('public.seq_res_reindex_job', 1, false);


--
-- Name: seq_reslink_id; Type: SEQUENCE SET; Schema: public; Owner: fhir
--

SELECT pg_catalog.setval('public.seq_reslink_id', 1, false);


--
-- Name: seq_resource_history_id; Type: SEQUENCE SET; Schema: public; Owner: fhir
--

SELECT pg_catalog.setval('public.seq_resource_history_id', 1, false);


--
-- Name: seq_resource_id; Type: SEQUENCE SET; Schema: public; Owner: fhir
--

SELECT pg_catalog.setval('public.seq_resource_id', 1, false);


--
-- Name: seq_resparmpresent_id; Type: SEQUENCE SET; Schema: public; Owner: fhir
--

SELECT pg_catalog.setval('public.seq_resparmpresent_id', 1, false);


--
-- Name: seq_restag_id; Type: SEQUENCE SET; Schema: public; Owner: fhir
--

SELECT pg_catalog.setval('public.seq_restag_id', 1, false);


--
-- Name: seq_search; Type: SEQUENCE SET; Schema: public; Owner: fhir
--

SELECT pg_catalog.setval('public.seq_search', 1, false);


--
-- Name: seq_search_inc; Type: SEQUENCE SET; Schema: public; Owner: fhir
--

SELECT pg_catalog.setval('public.seq_search_inc', 1, false);


--
-- Name: seq_search_res; Type: SEQUENCE SET; Schema: public; Owner: fhir
--

SELECT pg_catalog.setval('public.seq_search_res', 1, false);


--
-- Name: seq_spidx_coords; Type: SEQUENCE SET; Schema: public; Owner: fhir
--

SELECT pg_catalog.setval('public.seq_spidx_coords', 1, false);


--
-- Name: seq_spidx_date; Type: SEQUENCE SET; Schema: public; Owner: fhir
--

SELECT pg_catalog.setval('public.seq_spidx_date', 1, false);


--
-- Name: seq_spidx_number; Type: SEQUENCE SET; Schema: public; Owner: fhir
--

SELECT pg_catalog.setval('public.seq_spidx_number', 1, false);


--
-- Name: seq_spidx_quantity; Type: SEQUENCE SET; Schema: public; Owner: fhir
--

SELECT pg_catalog.setval('public.seq_spidx_quantity', 1, false);


--
-- Name: seq_spidx_quantity_nrml; Type: SEQUENCE SET; Schema: public; Owner: fhir
--

SELECT pg_catalog.setval('public.seq_spidx_quantity_nrml', 1, false);


--
-- Name: seq_spidx_string; Type: SEQUENCE SET; Schema: public; Owner: fhir
--

SELECT pg_catalog.setval('public.seq_spidx_string', 1, false);


--
-- Name: seq_spidx_token; Type: SEQUENCE SET; Schema: public; Owner: fhir
--

SELECT pg_catalog.setval('public.seq_spidx_token', 1, false);


--
-- Name: seq_spidx_uri; Type: SEQUENCE SET; Schema: public; Owner: fhir
--

SELECT pg_catalog.setval('public.seq_spidx_uri', 1, false);


--
-- Name: seq_subscription_id; Type: SEQUENCE SET; Schema: public; Owner: fhir
--

SELECT pg_catalog.setval('public.seq_subscription_id', 1, false);


--
-- Name: seq_tagdef_id; Type: SEQUENCE SET; Schema: public; Owner: fhir
--

SELECT pg_catalog.setval('public.seq_tagdef_id', 1, false);


--
-- Name: seq_valueset_c_dsgntn_pid; Type: SEQUENCE SET; Schema: public; Owner: fhir
--

SELECT pg_catalog.setval('public.seq_valueset_c_dsgntn_pid', 1, false);


--
-- Name: seq_valueset_concept_pid; Type: SEQUENCE SET; Schema: public; Owner: fhir
--

SELECT pg_catalog.setval('public.seq_valueset_concept_pid', 1, false);


--
-- Name: seq_valueset_pid; Type: SEQUENCE SET; Schema: public; Owner: fhir
--

SELECT pg_catalog.setval('public.seq_valueset_pid', 1, false);


--
-- Name: hfj_binary_storage_blob hfj_binary_storage_blob_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_binary_storage_blob
    ADD CONSTRAINT hfj_binary_storage_blob_pkey PRIMARY KEY (blob_id);


--
-- Name: hfj_blk_export_colfile hfj_blk_export_colfile_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_blk_export_colfile
    ADD CONSTRAINT hfj_blk_export_colfile_pkey PRIMARY KEY (pid);


--
-- Name: hfj_blk_export_collection hfj_blk_export_collection_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_blk_export_collection
    ADD CONSTRAINT hfj_blk_export_collection_pkey PRIMARY KEY (pid);


--
-- Name: hfj_blk_export_job hfj_blk_export_job_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_blk_export_job
    ADD CONSTRAINT hfj_blk_export_job_pkey PRIMARY KEY (pid);


--
-- Name: hfj_forced_id hfj_forced_id_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_forced_id
    ADD CONSTRAINT hfj_forced_id_pkey PRIMARY KEY (pid);


--
-- Name: hfj_history_tag hfj_history_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_history_tag
    ADD CONSTRAINT hfj_history_tag_pkey PRIMARY KEY (pid);


--
-- Name: hfj_idx_cmp_string_uniq hfj_idx_cmp_string_uniq_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_idx_cmp_string_uniq
    ADD CONSTRAINT hfj_idx_cmp_string_uniq_pkey PRIMARY KEY (pid);


--
-- Name: hfj_partition hfj_partition_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_partition
    ADD CONSTRAINT hfj_partition_pkey PRIMARY KEY (part_id);


--
-- Name: hfj_res_link hfj_res_link_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_res_link
    ADD CONSTRAINT hfj_res_link_pkey PRIMARY KEY (pid);


--
-- Name: hfj_res_param_present hfj_res_param_present_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_res_param_present
    ADD CONSTRAINT hfj_res_param_present_pkey PRIMARY KEY (pid);


--
-- Name: hfj_res_reindex_job hfj_res_reindex_job_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_res_reindex_job
    ADD CONSTRAINT hfj_res_reindex_job_pkey PRIMARY KEY (pid);


--
-- Name: hfj_res_tag hfj_res_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_res_tag
    ADD CONSTRAINT hfj_res_tag_pkey PRIMARY KEY (pid);


--
-- Name: hfj_res_ver hfj_res_ver_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_res_ver
    ADD CONSTRAINT hfj_res_ver_pkey PRIMARY KEY (pid);


--
-- Name: hfj_res_ver_prov hfj_res_ver_prov_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_res_ver_prov
    ADD CONSTRAINT hfj_res_ver_prov_pkey PRIMARY KEY (res_ver_pid);


--
-- Name: hfj_resource hfj_resource_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_resource
    ADD CONSTRAINT hfj_resource_pkey PRIMARY KEY (res_id);


--
-- Name: hfj_search_include hfj_search_include_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_search_include
    ADD CONSTRAINT hfj_search_include_pkey PRIMARY KEY (pid);


--
-- Name: hfj_search hfj_search_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_search
    ADD CONSTRAINT hfj_search_pkey PRIMARY KEY (pid);


--
-- Name: hfj_search_result hfj_search_result_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_search_result
    ADD CONSTRAINT hfj_search_result_pkey PRIMARY KEY (pid);


--
-- Name: hfj_spidx_coords hfj_spidx_coords_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_spidx_coords
    ADD CONSTRAINT hfj_spidx_coords_pkey PRIMARY KEY (sp_id);


--
-- Name: hfj_spidx_date hfj_spidx_date_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_spidx_date
    ADD CONSTRAINT hfj_spidx_date_pkey PRIMARY KEY (sp_id);


--
-- Name: hfj_spidx_number hfj_spidx_number_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_spidx_number
    ADD CONSTRAINT hfj_spidx_number_pkey PRIMARY KEY (sp_id);


--
-- Name: hfj_spidx_quantity_nrml hfj_spidx_quantity_nrml_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_spidx_quantity_nrml
    ADD CONSTRAINT hfj_spidx_quantity_nrml_pkey PRIMARY KEY (sp_id);


--
-- Name: hfj_spidx_quantity hfj_spidx_quantity_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_spidx_quantity
    ADD CONSTRAINT hfj_spidx_quantity_pkey PRIMARY KEY (sp_id);


--
-- Name: hfj_spidx_string hfj_spidx_string_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_spidx_string
    ADD CONSTRAINT hfj_spidx_string_pkey PRIMARY KEY (sp_id);


--
-- Name: hfj_spidx_token hfj_spidx_token_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_spidx_token
    ADD CONSTRAINT hfj_spidx_token_pkey PRIMARY KEY (sp_id);


--
-- Name: hfj_spidx_uri hfj_spidx_uri_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_spidx_uri
    ADD CONSTRAINT hfj_spidx_uri_pkey PRIMARY KEY (sp_id);


--
-- Name: hfj_subscription_stats hfj_subscription_stats_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_subscription_stats
    ADD CONSTRAINT hfj_subscription_stats_pkey PRIMARY KEY (pid);


--
-- Name: hfj_tag_def hfj_tag_def_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_tag_def
    ADD CONSTRAINT hfj_tag_def_pkey PRIMARY KEY (tag_id);


--
-- Name: hfj_blk_export_job idx_blkex_job_id; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_blk_export_job
    ADD CONSTRAINT idx_blkex_job_id UNIQUE (job_id);


--
-- Name: trm_codesystem_ver idx_codesystem_and_ver; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.trm_codesystem_ver
    ADD CONSTRAINT idx_codesystem_and_ver UNIQUE (codesystem_pid, cs_version_id);


--
-- Name: trm_concept idx_concept_cs_code; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.trm_concept
    ADD CONSTRAINT idx_concept_cs_code UNIQUE (codesystem_pid, codeval);


--
-- Name: trm_concept_map idx_concept_map_url; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.trm_concept_map
    ADD CONSTRAINT idx_concept_map_url UNIQUE (url, ver);


--
-- Name: trm_codesystem idx_cs_codesystem; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.trm_codesystem
    ADD CONSTRAINT idx_cs_codesystem UNIQUE (code_system_uri);


--
-- Name: mpi_link idx_empi_person_tgt; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.mpi_link
    ADD CONSTRAINT idx_empi_person_tgt UNIQUE (person_pid, target_pid);


--
-- Name: hfj_forced_id idx_forcedid_resid; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_forced_id
    ADD CONSTRAINT idx_forcedid_resid UNIQUE (resource_pid);


--
-- Name: hfj_forced_id idx_forcedid_type_fid; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_forced_id
    ADD CONSTRAINT idx_forcedid_type_fid UNIQUE (resource_type, forced_id);


--
-- Name: hfj_idx_cmp_string_uniq idx_idxcmpstruniq_string; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_idx_cmp_string_uniq
    ADD CONSTRAINT idx_idxcmpstruniq_string UNIQUE (idx_string);


--
-- Name: npm_package idx_pack_id; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.npm_package
    ADD CONSTRAINT idx_pack_id UNIQUE (package_id);


--
-- Name: npm_package_ver idx_packver; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.npm_package_ver
    ADD CONSTRAINT idx_packver UNIQUE (package_id, version_id);


--
-- Name: hfj_partition idx_part_name; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_partition
    ADD CONSTRAINT idx_part_name UNIQUE (part_name);


--
-- Name: hfj_history_tag idx_reshisttag_tagid; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_history_tag
    ADD CONSTRAINT idx_reshisttag_tagid UNIQUE (res_ver_pid, tag_id);


--
-- Name: hfj_res_tag idx_restag_tagid; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_res_tag
    ADD CONSTRAINT idx_restag_tagid UNIQUE (res_id, tag_id);


--
-- Name: hfj_res_ver idx_resver_id_ver; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_res_ver
    ADD CONSTRAINT idx_resver_id_ver UNIQUE (res_id, res_ver);


--
-- Name: hfj_search idx_search_uuid; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_search
    ADD CONSTRAINT idx_search_uuid UNIQUE (search_uuid);


--
-- Name: hfj_search_result idx_searchres_order; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_search_result
    ADD CONSTRAINT idx_searchres_order UNIQUE (search_pid, search_order);


--
-- Name: hfj_subscription_stats idx_subsc_resid; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_subscription_stats
    ADD CONSTRAINT idx_subsc_resid UNIQUE (res_id);


--
-- Name: hfj_tag_def idx_tagdef_typesyscode; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_tag_def
    ADD CONSTRAINT idx_tagdef_typesyscode UNIQUE (tag_type, tag_system, tag_code);


--
-- Name: trm_valueset idx_valueset_url; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.trm_valueset
    ADD CONSTRAINT idx_valueset_url UNIQUE (url, ver);


--
-- Name: trm_valueset_concept idx_vs_concept_cscd; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.trm_valueset_concept
    ADD CONSTRAINT idx_vs_concept_cscd UNIQUE (valueset_pid, system_url, codeval);


--
-- Name: trm_valueset_concept idx_vs_concept_order; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.trm_valueset_concept
    ADD CONSTRAINT idx_vs_concept_order UNIQUE (valueset_pid, valueset_order);


--
-- Name: mpi_link mpi_link_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.mpi_link
    ADD CONSTRAINT mpi_link_pkey PRIMARY KEY (pid);


--
-- Name: npm_package npm_package_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.npm_package
    ADD CONSTRAINT npm_package_pkey PRIMARY KEY (pid);


--
-- Name: npm_package_ver npm_package_ver_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.npm_package_ver
    ADD CONSTRAINT npm_package_ver_pkey PRIMARY KEY (pid);


--
-- Name: npm_package_ver_res npm_package_ver_res_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.npm_package_ver_res
    ADD CONSTRAINT npm_package_ver_res_pkey PRIMARY KEY (pid);


--
-- Name: trm_codesystem trm_codesystem_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.trm_codesystem
    ADD CONSTRAINT trm_codesystem_pkey PRIMARY KEY (pid);


--
-- Name: trm_codesystem_ver trm_codesystem_ver_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.trm_codesystem_ver
    ADD CONSTRAINT trm_codesystem_ver_pkey PRIMARY KEY (pid);


--
-- Name: trm_concept_desig trm_concept_desig_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.trm_concept_desig
    ADD CONSTRAINT trm_concept_desig_pkey PRIMARY KEY (pid);


--
-- Name: trm_concept_map_group trm_concept_map_group_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.trm_concept_map_group
    ADD CONSTRAINT trm_concept_map_group_pkey PRIMARY KEY (pid);


--
-- Name: trm_concept_map_grp_element trm_concept_map_grp_element_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.trm_concept_map_grp_element
    ADD CONSTRAINT trm_concept_map_grp_element_pkey PRIMARY KEY (pid);


--
-- Name: trm_concept_map_grp_elm_tgt trm_concept_map_grp_elm_tgt_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.trm_concept_map_grp_elm_tgt
    ADD CONSTRAINT trm_concept_map_grp_elm_tgt_pkey PRIMARY KEY (pid);


--
-- Name: trm_concept_map trm_concept_map_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.trm_concept_map
    ADD CONSTRAINT trm_concept_map_pkey PRIMARY KEY (pid);


--
-- Name: trm_concept_pc_link trm_concept_pc_link_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.trm_concept_pc_link
    ADD CONSTRAINT trm_concept_pc_link_pkey PRIMARY KEY (pid);


--
-- Name: trm_concept trm_concept_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.trm_concept
    ADD CONSTRAINT trm_concept_pkey PRIMARY KEY (pid);


--
-- Name: trm_concept_property trm_concept_property_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.trm_concept_property
    ADD CONSTRAINT trm_concept_property_pkey PRIMARY KEY (pid);


--
-- Name: trm_valueset_c_designation trm_valueset_c_designation_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.trm_valueset_c_designation
    ADD CONSTRAINT trm_valueset_c_designation_pkey PRIMARY KEY (pid);


--
-- Name: trm_valueset_concept trm_valueset_concept_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.trm_valueset_concept
    ADD CONSTRAINT trm_valueset_concept_pkey PRIMARY KEY (pid);


--
-- Name: trm_valueset trm_valueset_pkey; Type: CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.trm_valueset
    ADD CONSTRAINT trm_valueset_pkey PRIMARY KEY (pid);


--
-- Name: idx_blkex_exptime; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_blkex_exptime ON public.hfj_blk_export_job USING btree (exp_time);


--
-- Name: idx_cncpt_map_grp_cd; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_cncpt_map_grp_cd ON public.trm_concept_map_grp_element USING btree (source_code);


--
-- Name: idx_cncpt_mp_grp_elm_tgt_cd; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_cncpt_mp_grp_elm_tgt_cd ON public.trm_concept_map_grp_elm_tgt USING btree (target_code);


--
-- Name: idx_concept_indexstatus; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_concept_indexstatus ON public.trm_concept USING btree (index_status);


--
-- Name: idx_concept_updated; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_concept_updated ON public.trm_concept USING btree (concept_updated);


--
-- Name: idx_idxcmpstruniq_resource; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_idxcmpstruniq_resource ON public.hfj_idx_cmp_string_uniq USING btree (res_id);


--
-- Name: idx_indexstatus; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_indexstatus ON public.hfj_resource USING btree (sp_index_status);


--
-- Name: idx_packverres_url; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_packverres_url ON public.npm_package_ver_res USING btree (canonical_url);


--
-- Name: idx_res_date; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_res_date ON public.hfj_resource USING btree (res_updated);


--
-- Name: idx_res_lang; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_res_lang ON public.hfj_resource USING btree (res_type, res_language);


--
-- Name: idx_res_type; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_res_type ON public.hfj_resource USING btree (res_type);


--
-- Name: idx_resparmpresent_hashpres; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_resparmpresent_hashpres ON public.hfj_res_param_present USING btree (hash_presence);


--
-- Name: idx_resparmpresent_resid; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_resparmpresent_resid ON public.hfj_res_param_present USING btree (res_id);


--
-- Name: idx_resver_date; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_resver_date ON public.hfj_res_ver USING btree (res_updated);


--
-- Name: idx_resver_id_date; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_resver_id_date ON public.hfj_res_ver USING btree (res_id, res_updated);


--
-- Name: idx_resver_type_date; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_resver_type_date ON public.hfj_res_ver USING btree (res_type, res_updated);


--
-- Name: idx_resverprov_requestid; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_resverprov_requestid ON public.hfj_res_ver_prov USING btree (request_id);


--
-- Name: idx_resverprov_sourceuri; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_resverprov_sourceuri ON public.hfj_res_ver_prov USING btree (source_uri);


--
-- Name: idx_rl_dest; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_rl_dest ON public.hfj_res_link USING btree (target_resource_id);


--
-- Name: idx_rl_src; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_rl_src ON public.hfj_res_link USING btree (src_resource_id);


--
-- Name: idx_rl_tpathres; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_rl_tpathres ON public.hfj_res_link USING btree (src_path, target_resource_id);


--
-- Name: idx_search_created; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_search_created ON public.hfj_search USING btree (created);


--
-- Name: idx_search_restype_hashs; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_search_restype_hashs ON public.hfj_search USING btree (resource_type, search_query_string_hash, created);


--
-- Name: idx_sp_coords_hash; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_sp_coords_hash ON public.hfj_spidx_coords USING btree (hash_identity, sp_latitude, sp_longitude);


--
-- Name: idx_sp_coords_resid; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_sp_coords_resid ON public.hfj_spidx_coords USING btree (res_id);


--
-- Name: idx_sp_coords_updated; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_sp_coords_updated ON public.hfj_spidx_coords USING btree (sp_updated);


--
-- Name: idx_sp_date_hash; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_sp_date_hash ON public.hfj_spidx_date USING btree (hash_identity, sp_value_low, sp_value_high);


--
-- Name: idx_sp_date_hash_low; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_sp_date_hash_low ON public.hfj_spidx_date USING btree (hash_identity, sp_value_low);


--
-- Name: idx_sp_date_ord_hash; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_sp_date_ord_hash ON public.hfj_spidx_date USING btree (hash_identity, sp_value_low_date_ordinal, sp_value_high_date_ordinal);


--
-- Name: idx_sp_date_ord_hash_low; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_sp_date_ord_hash_low ON public.hfj_spidx_date USING btree (hash_identity, sp_value_low_date_ordinal);


--
-- Name: idx_sp_date_resid; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_sp_date_resid ON public.hfj_spidx_date USING btree (res_id);


--
-- Name: idx_sp_date_updated; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_sp_date_updated ON public.hfj_spidx_date USING btree (sp_updated);


--
-- Name: idx_sp_number_hash_val; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_sp_number_hash_val ON public.hfj_spidx_number USING btree (hash_identity, sp_value);


--
-- Name: idx_sp_number_resid; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_sp_number_resid ON public.hfj_spidx_number USING btree (res_id);


--
-- Name: idx_sp_number_updated; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_sp_number_updated ON public.hfj_spidx_number USING btree (sp_updated);


--
-- Name: idx_sp_qnty_nrml_hash; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_sp_qnty_nrml_hash ON public.hfj_spidx_quantity_nrml USING btree (hash_identity, sp_value);


--
-- Name: idx_sp_qnty_nrml_hash_sysun; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_sp_qnty_nrml_hash_sysun ON public.hfj_spidx_quantity_nrml USING btree (hash_identity_sys_units, sp_value);


--
-- Name: idx_sp_qnty_nrml_hash_un; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_sp_qnty_nrml_hash_un ON public.hfj_spidx_quantity_nrml USING btree (hash_identity_and_units, sp_value);


--
-- Name: idx_sp_qnty_nrml_resid; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_sp_qnty_nrml_resid ON public.hfj_spidx_quantity_nrml USING btree (res_id);


--
-- Name: idx_sp_qnty_nrml_updated; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_sp_qnty_nrml_updated ON public.hfj_spidx_quantity_nrml USING btree (sp_updated);


--
-- Name: idx_sp_quantity_hash; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_sp_quantity_hash ON public.hfj_spidx_quantity USING btree (hash_identity, sp_value);


--
-- Name: idx_sp_quantity_hash_sysun; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_sp_quantity_hash_sysun ON public.hfj_spidx_quantity USING btree (hash_identity_sys_units, sp_value);


--
-- Name: idx_sp_quantity_hash_un; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_sp_quantity_hash_un ON public.hfj_spidx_quantity USING btree (hash_identity_and_units, sp_value);


--
-- Name: idx_sp_quantity_resid; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_sp_quantity_resid ON public.hfj_spidx_quantity USING btree (res_id);


--
-- Name: idx_sp_quantity_updated; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_sp_quantity_updated ON public.hfj_spidx_quantity USING btree (sp_updated);


--
-- Name: idx_sp_string_hash_exct; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_sp_string_hash_exct ON public.hfj_spidx_string USING btree (hash_exact);


--
-- Name: idx_sp_string_hash_ident; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_sp_string_hash_ident ON public.hfj_spidx_string USING btree (hash_identity);


--
-- Name: idx_sp_string_hash_nrm; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_sp_string_hash_nrm ON public.hfj_spidx_string USING btree (hash_norm_prefix, sp_value_normalized);


--
-- Name: idx_sp_string_resid; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_sp_string_resid ON public.hfj_spidx_string USING btree (res_id);


--
-- Name: idx_sp_string_updated; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_sp_string_updated ON public.hfj_spidx_string USING btree (sp_updated);


--
-- Name: idx_sp_token_hash; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_sp_token_hash ON public.hfj_spidx_token USING btree (hash_identity);


--
-- Name: idx_sp_token_hash_s; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_sp_token_hash_s ON public.hfj_spidx_token USING btree (hash_sys);


--
-- Name: idx_sp_token_hash_sv; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_sp_token_hash_sv ON public.hfj_spidx_token USING btree (hash_sys_and_value);


--
-- Name: idx_sp_token_hash_v; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_sp_token_hash_v ON public.hfj_spidx_token USING btree (hash_value);


--
-- Name: idx_sp_token_resid; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_sp_token_resid ON public.hfj_spidx_token USING btree (res_id);


--
-- Name: idx_sp_token_updated; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_sp_token_updated ON public.hfj_spidx_token USING btree (sp_updated);


--
-- Name: idx_sp_uri; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_sp_uri ON public.hfj_spidx_uri USING btree (res_type, sp_name, sp_uri);


--
-- Name: idx_sp_uri_coords; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_sp_uri_coords ON public.hfj_spidx_uri USING btree (res_id);


--
-- Name: idx_sp_uri_hash_identity; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_sp_uri_hash_identity ON public.hfj_spidx_uri USING btree (hash_identity, sp_uri);


--
-- Name: idx_sp_uri_hash_uri; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_sp_uri_hash_uri ON public.hfj_spidx_uri USING btree (hash_uri);


--
-- Name: idx_sp_uri_restype_name; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_sp_uri_restype_name ON public.hfj_spidx_uri USING btree (res_type, sp_name);


--
-- Name: idx_sp_uri_updated; Type: INDEX; Schema: public; Owner: fhir
--

CREATE INDEX idx_sp_uri_updated ON public.hfj_spidx_uri USING btree (sp_updated);


--
-- Name: hfj_spidx_quantity_nrml fk2e5mi5vkdg14wq753u00c7s1c; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_spidx_quantity_nrml
    ADD CONSTRAINT fk2e5mi5vkdg14wq753u00c7s1c FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- Name: hfj_spidx_date fk30uej62bjadrnsrru0gp5oqwv; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_spidx_date
    ADD CONSTRAINT fk30uej62bjadrnsrru0gp5oqwv FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- Name: hfj_history_tag fk3gc37g8b2c9qcrrccw7s50inw; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_history_tag
    ADD CONSTRAINT fk3gc37g8b2c9qcrrccw7s50inw FOREIGN KEY (tag_id) REFERENCES public.hfj_tag_def(tag_id);


--
-- Name: hfj_spidx_number fk3ro12qh41h23gi7v5t1dsnjsc; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_spidx_number
    ADD CONSTRAINT fk3ro12qh41h23gi7v5t1dsnjsc FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- Name: hfj_res_tag fk4kiphkwif9illrg0jtooom2w1; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_res_tag
    ADD CONSTRAINT fk4kiphkwif9illrg0jtooom2w1 FOREIGN KEY (tag_id) REFERENCES public.hfj_tag_def(tag_id);


--
-- Name: hfj_blk_export_collection fk_blkexcol_job; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_blk_export_collection
    ADD CONSTRAINT fk_blkexcol_job FOREIGN KEY (job_pid) REFERENCES public.hfj_blk_export_job(pid);


--
-- Name: hfj_blk_export_colfile fk_blkexcolfile_collect; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_blk_export_colfile
    ADD CONSTRAINT fk_blkexcolfile_collect FOREIGN KEY (collection_pid) REFERENCES public.hfj_blk_export_collection(pid);


--
-- Name: trm_codesystem_ver fk_codesysver_cs_id; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.trm_codesystem_ver
    ADD CONSTRAINT fk_codesysver_cs_id FOREIGN KEY (codesystem_pid) REFERENCES public.trm_codesystem(pid);


--
-- Name: trm_codesystem_ver fk_codesysver_res_id; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.trm_codesystem_ver
    ADD CONSTRAINT fk_codesysver_res_id FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- Name: trm_concept fk_concept_pid_cs_pid; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.trm_concept
    ADD CONSTRAINT fk_concept_pid_cs_pid FOREIGN KEY (codesystem_pid) REFERENCES public.trm_codesystem_ver(pid);


--
-- Name: trm_concept_desig fk_conceptdesig_concept; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.trm_concept_desig
    ADD CONSTRAINT fk_conceptdesig_concept FOREIGN KEY (concept_pid) REFERENCES public.trm_concept(pid);


--
-- Name: trm_concept_desig fk_conceptdesig_csv; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.trm_concept_desig
    ADD CONSTRAINT fk_conceptdesig_csv FOREIGN KEY (cs_ver_pid) REFERENCES public.trm_codesystem_ver(pid);


--
-- Name: trm_concept_property fk_conceptprop_concept; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.trm_concept_property
    ADD CONSTRAINT fk_conceptprop_concept FOREIGN KEY (concept_pid) REFERENCES public.trm_concept(pid);


--
-- Name: trm_concept_property fk_conceptprop_csv; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.trm_concept_property
    ADD CONSTRAINT fk_conceptprop_csv FOREIGN KEY (cs_ver_pid) REFERENCES public.trm_codesystem_ver(pid);


--
-- Name: mpi_link fk_empi_link_golden_resource; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.mpi_link
    ADD CONSTRAINT fk_empi_link_golden_resource FOREIGN KEY (golden_resource_pid) REFERENCES public.hfj_resource(res_id);


--
-- Name: mpi_link fk_empi_link_person; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.mpi_link
    ADD CONSTRAINT fk_empi_link_person FOREIGN KEY (person_pid) REFERENCES public.hfj_resource(res_id);


--
-- Name: mpi_link fk_empi_link_target; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.mpi_link
    ADD CONSTRAINT fk_empi_link_target FOREIGN KEY (target_pid) REFERENCES public.hfj_resource(res_id);


--
-- Name: hfj_forced_id fk_forcedid_resource; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_forced_id
    ADD CONSTRAINT fk_forcedid_resource FOREIGN KEY (resource_pid) REFERENCES public.hfj_resource(res_id);


--
-- Name: hfj_history_tag fk_historytag_history; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_history_tag
    ADD CONSTRAINT fk_historytag_history FOREIGN KEY (res_ver_pid) REFERENCES public.hfj_res_ver(pid);


--
-- Name: hfj_idx_cmp_string_uniq fk_idxcmpstruniq_res_id; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_idx_cmp_string_uniq
    ADD CONSTRAINT fk_idxcmpstruniq_res_id FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- Name: npm_package_ver_res fk_npm_packverres_packver; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.npm_package_ver_res
    ADD CONSTRAINT fk_npm_packverres_packver FOREIGN KEY (packver_pid) REFERENCES public.npm_package_ver(pid);


--
-- Name: npm_package_ver fk_npm_pkv_pkg; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.npm_package_ver
    ADD CONSTRAINT fk_npm_pkv_pkg FOREIGN KEY (package_pid) REFERENCES public.npm_package(pid);


--
-- Name: npm_package_ver fk_npm_pkv_resid; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.npm_package_ver
    ADD CONSTRAINT fk_npm_pkv_resid FOREIGN KEY (binary_res_id) REFERENCES public.hfj_resource(res_id);


--
-- Name: npm_package_ver_res fk_npm_pkvr_resid; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.npm_package_ver_res
    ADD CONSTRAINT fk_npm_pkvr_resid FOREIGN KEY (binary_res_id) REFERENCES public.hfj_resource(res_id);


--
-- Name: hfj_res_link fk_reslink_source; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_res_link
    ADD CONSTRAINT fk_reslink_source FOREIGN KEY (src_resource_id) REFERENCES public.hfj_resource(res_id);


--
-- Name: hfj_res_link fk_reslink_target; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_res_link
    ADD CONSTRAINT fk_reslink_target FOREIGN KEY (target_resource_id) REFERENCES public.hfj_resource(res_id);


--
-- Name: hfj_res_ver fk_resource_history_resource; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_res_ver
    ADD CONSTRAINT fk_resource_history_resource FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- Name: hfj_res_param_present fk_resparmpres_resid; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_res_param_present
    ADD CONSTRAINT fk_resparmpres_resid FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- Name: hfj_res_tag fk_restag_resource; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_res_tag
    ADD CONSTRAINT fk_restag_resource FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- Name: hfj_res_ver_prov fk_resverprov_res_pid; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_res_ver_prov
    ADD CONSTRAINT fk_resverprov_res_pid FOREIGN KEY (res_pid) REFERENCES public.hfj_resource(res_id);


--
-- Name: hfj_res_ver_prov fk_resverprov_resver_pid; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_res_ver_prov
    ADD CONSTRAINT fk_resverprov_resver_pid FOREIGN KEY (res_ver_pid) REFERENCES public.hfj_res_ver(pid);


--
-- Name: hfj_search_include fk_searchinc_search; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_search_include
    ADD CONSTRAINT fk_searchinc_search FOREIGN KEY (search_pid) REFERENCES public.hfj_search(pid);


--
-- Name: hfj_spidx_string fk_spidxstr_resource; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_spidx_string
    ADD CONSTRAINT fk_spidxstr_resource FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- Name: hfj_subscription_stats fk_subsc_resource_id; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_subscription_stats
    ADD CONSTRAINT fk_subsc_resource_id FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- Name: trm_concept_map_grp_element fk_tcmgelement_group; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.trm_concept_map_grp_element
    ADD CONSTRAINT fk_tcmgelement_group FOREIGN KEY (concept_map_group_pid) REFERENCES public.trm_concept_map_group(pid);


--
-- Name: trm_concept_map_grp_elm_tgt fk_tcmgetarget_element; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.trm_concept_map_grp_elm_tgt
    ADD CONSTRAINT fk_tcmgetarget_element FOREIGN KEY (concept_map_grp_elm_pid) REFERENCES public.trm_concept_map_grp_element(pid);


--
-- Name: trm_concept_map_group fk_tcmgroup_conceptmap; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.trm_concept_map_group
    ADD CONSTRAINT fk_tcmgroup_conceptmap FOREIGN KEY (concept_map_pid) REFERENCES public.trm_concept_map(pid);


--
-- Name: trm_concept_pc_link fk_term_conceptpc_child; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.trm_concept_pc_link
    ADD CONSTRAINT fk_term_conceptpc_child FOREIGN KEY (child_pid) REFERENCES public.trm_concept(pid);


--
-- Name: trm_concept_pc_link fk_term_conceptpc_cs; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.trm_concept_pc_link
    ADD CONSTRAINT fk_term_conceptpc_cs FOREIGN KEY (codesystem_pid) REFERENCES public.trm_codesystem_ver(pid);


--
-- Name: trm_concept_pc_link fk_term_conceptpc_parent; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.trm_concept_pc_link
    ADD CONSTRAINT fk_term_conceptpc_parent FOREIGN KEY (parent_pid) REFERENCES public.trm_concept(pid);


--
-- Name: trm_valueset_c_designation fk_trm_valueset_concept_pid; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.trm_valueset_c_designation
    ADD CONSTRAINT fk_trm_valueset_concept_pid FOREIGN KEY (valueset_concept_pid) REFERENCES public.trm_valueset_concept(pid);


--
-- Name: trm_valueset_concept fk_trm_valueset_pid; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.trm_valueset_concept
    ADD CONSTRAINT fk_trm_valueset_pid FOREIGN KEY (valueset_pid) REFERENCES public.trm_valueset(pid);


--
-- Name: trm_valueset_c_designation fk_trm_vscd_vs_pid; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.trm_valueset_c_designation
    ADD CONSTRAINT fk_trm_vscd_vs_pid FOREIGN KEY (valueset_pid) REFERENCES public.trm_valueset(pid);


--
-- Name: trm_codesystem fk_trmcodesystem_curver; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.trm_codesystem
    ADD CONSTRAINT fk_trmcodesystem_curver FOREIGN KEY (current_version_pid) REFERENCES public.trm_codesystem_ver(pid);


--
-- Name: trm_codesystem fk_trmcodesystem_res; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.trm_codesystem
    ADD CONSTRAINT fk_trmcodesystem_res FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- Name: trm_concept_map fk_trmconceptmap_res; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.trm_concept_map
    ADD CONSTRAINT fk_trmconceptmap_res FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- Name: trm_valueset fk_trmvalueset_res; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.trm_valueset
    ADD CONSTRAINT fk_trmvalueset_res FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- Name: hfj_spidx_token fkec4ct4jmgago3lxhrgrrq4pwy; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_spidx_token
    ADD CONSTRAINT fkec4ct4jmgago3lxhrgrrq4pwy FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- Name: hfj_spidx_uri fkfa98npqetoy8qtbjs69safrju; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_spidx_uri
    ADD CONSTRAINT fkfa98npqetoy8qtbjs69safrju FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- Name: hfj_spidx_quantity fkga8jnecq3et3xrhx9vpg7ahtq; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_spidx_quantity
    ADD CONSTRAINT fkga8jnecq3et3xrhx9vpg7ahtq FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- Name: hfj_spidx_coords fknxqpd20g9qggkvcwkospuc8cb; Type: FK CONSTRAINT; Schema: public; Owner: fhir
--

ALTER TABLE ONLY public.hfj_spidx_coords
    ADD CONSTRAINT fknxqpd20g9qggkvcwkospuc8cb FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- PostgreSQL database dump complete
--

