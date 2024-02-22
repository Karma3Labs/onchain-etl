--
-- PostgreSQL database dump
--

-- Dumped from database version 15.6 (Debian 15.6-1.pgdg120+2)
-- Dumped by pg_dump version 16.1

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
-- Name: base_addresses_with_token_standards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.base_addresses_with_token_standards (
    contract_address character varying(42) NOT NULL,
    token_standard character varying NOT NULL
);


ALTER TABLE public.base_addresses_with_token_standards OWNER TO postgres;

--
-- Name: base_transactions_sums; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.base_transactions_sums (
    from_address character varying(42) NOT NULL,
    max_timestamp timestamp without time zone NOT NULL,
    min_timestamp timestamp without time zone NOT NULL,
    to_address character varying(42),
    total_gas_paid bigint NOT NULL,
    txn_value numeric NOT NULL,
    txn_count numeric NOT NULL,
    to_address_is_contract boolean NOT NULL,
    to_address_is_erc20 boolean NOT NULL,
    to_address_is_erc721 boolean NOT NULL
);


ALTER TABLE public.base_transactions_sums OWNER TO postgres;

--
-- Name: deprecated_blocks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deprecated_blocks (
    number bigint NOT NULL,
    hash character varying(255) NOT NULL,
    parent_hash character varying(255),
    nonce character varying(18),
    sha3_uncles character varying(255),
    logs_bloom text,
    transactions_root character varying(255),
    state_root character varying(255),
    receipts_root character varying(255),
    miner character varying(255),
    difficulty numeric,
    total_difficulty numeric,
    size bigint,
    extra_data text,
    gas_limit bigint,
    gas_used bigint,
    "timestamp" bigint,
    transaction_count integer,
    base_fee_per_gas bigint,
    withdrawals_root character varying(255),
    withdrawals text
);


ALTER TABLE public.deprecated_blocks OWNER TO postgres;

--
-- Name: deprecated_contracts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deprecated_contracts (
    address character varying(42) NOT NULL,
    is_erc20 boolean NOT NULL,
    is_erc721 boolean NOT NULL
);


ALTER TABLE public.deprecated_contracts OWNER TO postgres;

--
-- Name: deprecated_tmp_data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deprecated_tmp_data (
    from_address text,
    to_address text,
    min_timestamp timestamp without time zone,
    max_timestamp timestamp without time zone,
    total_gas_value double precision,
    total_txn_value double precision,
    txn_count bigint,
    to_address_is_contract boolean,
    to_address_is_erc20 boolean,
    to_address_is_erc721 boolean
);


ALTER TABLE public.deprecated_tmp_data OWNER TO postgres;

--
-- Name: deprecated_transaction_sums; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deprecated_transaction_sums (
    from_address character varying(42) NOT NULL,
    to_address character varying(42),
    min_timestamp timestamp without time zone NOT NULL,
    max_timestamp timestamp without time zone NOT NULL,
    gas_price bigint NOT NULL,
    gas_used bigint NOT NULL,
    txn_value numeric NOT NULL,
    to_address_is_contract boolean NOT NULL,
    to_address_is_erc20 boolean NOT NULL,
    to_address_is_erc721 boolean NOT NULL
);


ALTER TABLE public.deprecated_transaction_sums OWNER TO postgres;

--
-- Name: deprecated_transaction_sums_old; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deprecated_transaction_sums_old (
    from_address character varying(42) NOT NULL,
    to_address character varying(42),
    gas_price bigint NOT NULL,
    gas_used bigint NOT NULL,
    txn_value numeric NOT NULL,
    to_address_is_contract boolean NOT NULL,
    to_address_is_erc20 boolean NOT NULL,
    to_address_is_erc721 boolean NOT NULL
);


ALTER TABLE public.deprecated_transaction_sums_old OWNER TO postgres;

--
-- Name: deprecated_transaction_sums_with_count; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deprecated_transaction_sums_with_count (
    from_address character varying(42) NOT NULL,
    to_address character varying(42),
    min_timestamp timestamp without time zone NOT NULL,
    max_timestamp timestamp without time zone NOT NULL,
    gas_price bigint NOT NULL,
    gas_used bigint NOT NULL,
    txn_value numeric NOT NULL,
    txn_count numeric NOT NULL,
    to_address_is_contract boolean NOT NULL,
    to_address_is_erc20 boolean NOT NULL,
    to_address_is_erc721 boolean NOT NULL
);


ALTER TABLE public.deprecated_transaction_sums_with_count OWNER TO postgres;

--
-- Name: deprecated_transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deprecated_transactions (
    hash character varying(255) NOT NULL,
    nonce bigint,
    block_hash character varying(255),
    block_number bigint,
    transaction_index integer,
    from_address character varying(255),
    to_address character varying(255),
    value numeric,
    gas bigint,
    gas_price bigint,
    input text,
    block_timestamp bigint,
    max_fee_per_gas bigint,
    max_priority_fee_per_gas bigint,
    transaction_type integer
);


ALTER TABLE public.deprecated_transactions OWNER TO postgres;

--
-- Name: dune_labels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dune_labels (
    address character varying(255) NOT NULL,
    blockchain character varying(50) NOT NULL,
    category character varying(50) NOT NULL,
    label_type character varying(50) NOT NULL,
    name character varying(2000),
    model_name character varying(100),
    source character varying(100),
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.dune_labels OWNER TO postgres;

--
-- Name: ens_addresses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ens_addresses (
    address character varying(255) NOT NULL,
    name character varying(65025),
    blockchain character varying(50),
    updated_at timestamp without time zone
);


ALTER TABLE public.ens_addresses OWNER TO postgres;

--
-- Name: eth_base_op_non_eoa_address_labels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eth_base_op_non_eoa_address_labels (
    address character varying(42) NOT NULL,
    category character varying NOT NULL,
    label_type character varying NOT NULL,
    model_name character varying NOT NULL
);


ALTER TABLE public.eth_base_op_non_eoa_address_labels OWNER TO postgres;

--
-- Name: eth_transactions_sums; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eth_transactions_sums (
    from_address character varying(42) NOT NULL,
    to_address character varying(42) NOT NULL,
    min_timestamp timestamp without time zone NOT NULL,
    max_timestamp timestamp without time zone NOT NULL,
    total_gas_value numeric NOT NULL,
    total_txn_value numeric NOT NULL,
    txn_count integer NOT NULL,
    to_address_is_contract boolean NOT NULL,
    to_address_is_erc20 boolean NOT NULL,
    to_address_is_erc721 boolean NOT NULL
)
PARTITION BY RANGE (max_timestamp);


ALTER TABLE public.eth_transactions_sums OWNER TO postgres;

--
-- Name: eth_transactions_sums_y2023m01; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eth_transactions_sums_y2023m01 (
    from_address character varying(42) NOT NULL,
    to_address character varying(42) NOT NULL,
    min_timestamp timestamp without time zone NOT NULL,
    max_timestamp timestamp without time zone NOT NULL,
    total_gas_value numeric NOT NULL,
    total_txn_value numeric NOT NULL,
    txn_count integer NOT NULL,
    to_address_is_contract boolean NOT NULL,
    to_address_is_erc20 boolean NOT NULL,
    to_address_is_erc721 boolean NOT NULL
);


ALTER TABLE public.eth_transactions_sums_y2023m01 OWNER TO postgres;

--
-- Name: eth_transactions_sums_y2023m02; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eth_transactions_sums_y2023m02 (
    from_address character varying(42) NOT NULL,
    to_address character varying(42) NOT NULL,
    min_timestamp timestamp without time zone NOT NULL,
    max_timestamp timestamp without time zone NOT NULL,
    total_gas_value numeric NOT NULL,
    total_txn_value numeric NOT NULL,
    txn_count integer NOT NULL,
    to_address_is_contract boolean NOT NULL,
    to_address_is_erc20 boolean NOT NULL,
    to_address_is_erc721 boolean NOT NULL
);


ALTER TABLE public.eth_transactions_sums_y2023m02 OWNER TO postgres;

--
-- Name: eth_transactions_sums_y2023m03; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eth_transactions_sums_y2023m03 (
    from_address character varying(42) NOT NULL,
    to_address character varying(42) NOT NULL,
    min_timestamp timestamp without time zone NOT NULL,
    max_timestamp timestamp without time zone NOT NULL,
    total_gas_value numeric NOT NULL,
    total_txn_value numeric NOT NULL,
    txn_count integer NOT NULL,
    to_address_is_contract boolean NOT NULL,
    to_address_is_erc20 boolean NOT NULL,
    to_address_is_erc721 boolean NOT NULL
);


ALTER TABLE public.eth_transactions_sums_y2023m03 OWNER TO postgres;

--
-- Name: eth_transactions_sums_y2023m04; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eth_transactions_sums_y2023m04 (
    from_address character varying(42) NOT NULL,
    to_address character varying(42) NOT NULL,
    min_timestamp timestamp without time zone NOT NULL,
    max_timestamp timestamp without time zone NOT NULL,
    total_gas_value numeric NOT NULL,
    total_txn_value numeric NOT NULL,
    txn_count integer NOT NULL,
    to_address_is_contract boolean NOT NULL,
    to_address_is_erc20 boolean NOT NULL,
    to_address_is_erc721 boolean NOT NULL
);


ALTER TABLE public.eth_transactions_sums_y2023m04 OWNER TO postgres;

--
-- Name: eth_transactions_sums_y2023m05; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eth_transactions_sums_y2023m05 (
    from_address character varying(42) NOT NULL,
    to_address character varying(42) NOT NULL,
    min_timestamp timestamp without time zone NOT NULL,
    max_timestamp timestamp without time zone NOT NULL,
    total_gas_value numeric NOT NULL,
    total_txn_value numeric NOT NULL,
    txn_count integer NOT NULL,
    to_address_is_contract boolean NOT NULL,
    to_address_is_erc20 boolean NOT NULL,
    to_address_is_erc721 boolean NOT NULL
);


ALTER TABLE public.eth_transactions_sums_y2023m05 OWNER TO postgres;

--
-- Name: eth_transactions_sums_y2023m06; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eth_transactions_sums_y2023m06 (
    from_address character varying(42) NOT NULL,
    to_address character varying(42) NOT NULL,
    min_timestamp timestamp without time zone NOT NULL,
    max_timestamp timestamp without time zone NOT NULL,
    total_gas_value numeric NOT NULL,
    total_txn_value numeric NOT NULL,
    txn_count integer NOT NULL,
    to_address_is_contract boolean NOT NULL,
    to_address_is_erc20 boolean NOT NULL,
    to_address_is_erc721 boolean NOT NULL
);


ALTER TABLE public.eth_transactions_sums_y2023m06 OWNER TO postgres;

--
-- Name: eth_transactions_sums_y2023m07; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eth_transactions_sums_y2023m07 (
    from_address character varying(42) NOT NULL,
    to_address character varying(42) NOT NULL,
    min_timestamp timestamp without time zone NOT NULL,
    max_timestamp timestamp without time zone NOT NULL,
    total_gas_value numeric NOT NULL,
    total_txn_value numeric NOT NULL,
    txn_count integer NOT NULL,
    to_address_is_contract boolean NOT NULL,
    to_address_is_erc20 boolean NOT NULL,
    to_address_is_erc721 boolean NOT NULL
);


ALTER TABLE public.eth_transactions_sums_y2023m07 OWNER TO postgres;

--
-- Name: eth_transactions_sums_y2023m08; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eth_transactions_sums_y2023m08 (
    from_address character varying(42) NOT NULL,
    to_address character varying(42) NOT NULL,
    min_timestamp timestamp without time zone NOT NULL,
    max_timestamp timestamp without time zone NOT NULL,
    total_gas_value numeric NOT NULL,
    total_txn_value numeric NOT NULL,
    txn_count integer NOT NULL,
    to_address_is_contract boolean NOT NULL,
    to_address_is_erc20 boolean NOT NULL,
    to_address_is_erc721 boolean NOT NULL
);


ALTER TABLE public.eth_transactions_sums_y2023m08 OWNER TO postgres;

--
-- Name: eth_transactions_sums_y2023m09; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eth_transactions_sums_y2023m09 (
    from_address character varying(42) NOT NULL,
    to_address character varying(42) NOT NULL,
    min_timestamp timestamp without time zone NOT NULL,
    max_timestamp timestamp without time zone NOT NULL,
    total_gas_value numeric NOT NULL,
    total_txn_value numeric NOT NULL,
    txn_count integer NOT NULL,
    to_address_is_contract boolean NOT NULL,
    to_address_is_erc20 boolean NOT NULL,
    to_address_is_erc721 boolean NOT NULL
);


ALTER TABLE public.eth_transactions_sums_y2023m09 OWNER TO postgres;

--
-- Name: eth_transactions_sums_y2023m10; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eth_transactions_sums_y2023m10 (
    from_address character varying(42) NOT NULL,
    to_address character varying(42) NOT NULL,
    min_timestamp timestamp without time zone NOT NULL,
    max_timestamp timestamp without time zone NOT NULL,
    total_gas_value numeric NOT NULL,
    total_txn_value numeric NOT NULL,
    txn_count integer NOT NULL,
    to_address_is_contract boolean NOT NULL,
    to_address_is_erc20 boolean NOT NULL,
    to_address_is_erc721 boolean NOT NULL
);


ALTER TABLE public.eth_transactions_sums_y2023m10 OWNER TO postgres;

--
-- Name: eth_transactions_sums_y2023m11; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eth_transactions_sums_y2023m11 (
    from_address character varying(42) NOT NULL,
    to_address character varying(42) NOT NULL,
    min_timestamp timestamp without time zone NOT NULL,
    max_timestamp timestamp without time zone NOT NULL,
    total_gas_value numeric NOT NULL,
    total_txn_value numeric NOT NULL,
    txn_count integer NOT NULL,
    to_address_is_contract boolean NOT NULL,
    to_address_is_erc20 boolean NOT NULL,
    to_address_is_erc721 boolean NOT NULL
);


ALTER TABLE public.eth_transactions_sums_y2023m11 OWNER TO postgres;

--
-- Name: eth_transactions_sums_y2023m12; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eth_transactions_sums_y2023m12 (
    from_address character varying(42) NOT NULL,
    to_address character varying(42) NOT NULL,
    min_timestamp timestamp without time zone NOT NULL,
    max_timestamp timestamp without time zone NOT NULL,
    total_gas_value numeric NOT NULL,
    total_txn_value numeric NOT NULL,
    txn_count integer NOT NULL,
    to_address_is_contract boolean NOT NULL,
    to_address_is_erc20 boolean NOT NULL,
    to_address_is_erc721 boolean NOT NULL
);


ALTER TABLE public.eth_transactions_sums_y2023m12 OWNER TO postgres;

--
-- Name: eth_transactions_sums_y2024m01; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eth_transactions_sums_y2024m01 (
    from_address character varying(42) NOT NULL,
    to_address character varying(42) NOT NULL,
    min_timestamp timestamp without time zone NOT NULL,
    max_timestamp timestamp without time zone NOT NULL,
    total_gas_value numeric NOT NULL,
    total_txn_value numeric NOT NULL,
    txn_count integer NOT NULL,
    to_address_is_contract boolean NOT NULL,
    to_address_is_erc20 boolean NOT NULL,
    to_address_is_erc721 boolean NOT NULL
);


ALTER TABLE public.eth_transactions_sums_y2024m01 OWNER TO postgres;

--
-- Name: eth_transactions_sums_y2024m02; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eth_transactions_sums_y2024m02 (
    from_address character varying(42) NOT NULL,
    to_address character varying(42) NOT NULL,
    min_timestamp timestamp without time zone NOT NULL,
    max_timestamp timestamp without time zone NOT NULL,
    total_gas_value numeric NOT NULL,
    total_txn_value numeric NOT NULL,
    txn_count integer NOT NULL,
    to_address_is_contract boolean NOT NULL,
    to_address_is_erc20 boolean NOT NULL,
    to_address_is_erc721 boolean NOT NULL
);


ALTER TABLE public.eth_transactions_sums_y2024m02 OWNER TO postgres;

--
-- Name: eth_transactions_sums_y2024m03; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eth_transactions_sums_y2024m03 (
    from_address character varying(42) NOT NULL,
    to_address character varying(42) NOT NULL,
    min_timestamp timestamp without time zone NOT NULL,
    max_timestamp timestamp without time zone NOT NULL,
    total_gas_value numeric NOT NULL,
    total_txn_value numeric NOT NULL,
    txn_count integer NOT NULL,
    to_address_is_contract boolean NOT NULL,
    to_address_is_erc20 boolean NOT NULL,
    to_address_is_erc721 boolean NOT NULL
);


ALTER TABLE public.eth_transactions_sums_y2024m03 OWNER TO postgres;

--
-- Name: ethereum_addresses_with_token_standards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ethereum_addresses_with_token_standards (
    contract_address character varying(42) NOT NULL,
    token_standard character varying NOT NULL
);


ALTER TABLE public.ethereum_addresses_with_token_standards OWNER TO postgres;

--
-- Name: optimism_addresses_with_token_standards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.optimism_addresses_with_token_standards (
    contract_address character varying(42) NOT NULL,
    token_standard character varying NOT NULL
);


ALTER TABLE public.optimism_addresses_with_token_standards OWNER TO postgres;

--
-- Name: k3l_address_labels; Type: MATERIALIZED VIEW; Schema: public; Owner: postgres
--

CREATE MATERIALIZED VIEW public.k3l_address_labels AS
 SELECT row_number() OVER () AS pseudo_id,
        CASE COALESCE(eth.token_standard, base.token_standard, op.token_standard, 'NOT_TOKEN'::character varying)
            WHEN 'NOT_TOKEN'::text THEN non_eoa.category
            ELSE COALESCE(eth.token_standard, base.token_standard, op.token_standard)
        END AS category,
        CASE
            WHEN (base.token_standard IS NOT NULL) THEN 'base'::character varying
            WHEN (op.token_standard IS NOT NULL) THEN 'optimism'::character varying
            WHEN (eth.token_standard IS NOT NULL) THEN 'ethereum'::character varying
            ELSE dune_labels.blockchain
        END AS blockchain,
    non_eoa.address,
    non_eoa.label_type,
    non_eoa.model_name,
    dune_labels.name
   FROM ((((public.eth_base_op_non_eoa_address_labels non_eoa
     LEFT JOIN public.dune_labels ON (((dune_labels.address)::text = (non_eoa.address)::text)))
     LEFT JOIN public.base_addresses_with_token_standards base ON (((non_eoa.address)::text = (base.contract_address)::text)))
     LEFT JOIN public.optimism_addresses_with_token_standards op ON (((non_eoa.address)::text = (op.contract_address)::text)))
     LEFT JOIN public.ethereum_addresses_with_token_standards eth ON (((non_eoa.address)::text = (eth.contract_address)::text)))
  WITH NO DATA;


ALTER MATERIALIZED VIEW public.k3l_address_labels OWNER TO postgres;

--
-- Name: k3l_address_labels_deduped; Type: MATERIALIZED VIEW; Schema: public; Owner: postgres
--

CREATE MATERIALIZED VIEW public.k3l_address_labels_deduped AS
 WITH labels AS (
         SELECT
                CASE
                    WHEN (((COALESCE(eth.token_standard, base.token_standard, op.token_standard, 'NOT_TOKEN'::character varying))::text = 'NOT_TOKEN'::text) AND ((non_eoa.category)::text <> 'contracts'::text)) THEN false
                    ELSE true
                END AS is_token,
                CASE COALESCE(eth.token_standard, base.token_standard, op.token_standard, 'NOT_TOKEN'::character varying)
                    WHEN 'NOT_TOKEN'::text THEN non_eoa.category
                    ELSE COALESCE(eth.token_standard, base.token_standard, op.token_standard)
                END AS category,
                CASE
                    WHEN (base.token_standard IS NOT NULL) THEN 'base'::character varying
                    WHEN (op.token_standard IS NOT NULL) THEN 'optimism'::character varying
                    WHEN (eth.token_standard IS NOT NULL) THEN 'ethereum'::character varying
                    ELSE dune_labels.blockchain
                END AS blockchain,
            non_eoa.address,
            non_eoa.label_type,
            non_eoa.model_name,
            dune_labels.name
           FROM ((((public.eth_base_op_non_eoa_address_labels non_eoa
             LEFT JOIN public.dune_labels ON (((dune_labels.address)::text = (non_eoa.address)::text)))
             LEFT JOIN public.base_addresses_with_token_standards base ON (((non_eoa.address)::text = (base.contract_address)::text)))
             LEFT JOIN public.optimism_addresses_with_token_standards op ON (((non_eoa.address)::text = (op.contract_address)::text)))
             LEFT JOIN public.ethereum_addresses_with_token_standards eth ON (((non_eoa.address)::text = (eth.contract_address)::text)))
        )
 SELECT labels.address,
    bool_or(labels.is_token) AS is_token,
    (array_agg(labels.category))[1] AS category,
    (array_agg(labels.label_type))[1] AS label_type,
    (array_agg(labels.model_name))[1] AS model_name,
    (array_agg(labels.name))[1] AS name,
    (array_agg(labels.blockchain))[1] AS blockchain
   FROM labels
  GROUP BY labels.address
  WITH NO DATA;


ALTER MATERIALIZED VIEW public.k3l_address_labels_deduped OWNER TO postgres;

--
-- Name: labeled_addresses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.labeled_addresses (
    address character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    blockchain character varying(100) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.labeled_addresses OWNER TO postgres;

--
-- Name: optimism_transaction_sums; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.optimism_transaction_sums (
    from_address character varying(42) NOT NULL,
    to_address character varying(42),
    min_timestamp timestamp without time zone NOT NULL,
    max_timestamp timestamp without time zone NOT NULL,
    gas_price bigint NOT NULL,
    gas_used bigint NOT NULL,
    txn_value numeric NOT NULL
);


ALTER TABLE public.optimism_transaction_sums OWNER TO postgres;

--
-- Name: eth_transactions_sums_y2023m01; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eth_transactions_sums ATTACH PARTITION public.eth_transactions_sums_y2023m01 FOR VALUES FROM ('2023-01-01 00:00:00') TO ('2023-02-01 00:00:00');


--
-- Name: eth_transactions_sums_y2023m02; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eth_transactions_sums ATTACH PARTITION public.eth_transactions_sums_y2023m02 FOR VALUES FROM ('2023-02-01 00:00:00') TO ('2023-03-01 00:00:00');


--
-- Name: eth_transactions_sums_y2023m03; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eth_transactions_sums ATTACH PARTITION public.eth_transactions_sums_y2023m03 FOR VALUES FROM ('2023-03-01 00:00:00') TO ('2023-04-01 00:00:00');


--
-- Name: eth_transactions_sums_y2023m04; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eth_transactions_sums ATTACH PARTITION public.eth_transactions_sums_y2023m04 FOR VALUES FROM ('2023-04-01 00:00:00') TO ('2023-05-01 00:00:00');


--
-- Name: eth_transactions_sums_y2023m05; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eth_transactions_sums ATTACH PARTITION public.eth_transactions_sums_y2023m05 FOR VALUES FROM ('2023-05-01 00:00:00') TO ('2023-06-01 00:00:00');


--
-- Name: eth_transactions_sums_y2023m06; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eth_transactions_sums ATTACH PARTITION public.eth_transactions_sums_y2023m06 FOR VALUES FROM ('2023-06-01 00:00:00') TO ('2023-07-01 00:00:00');


--
-- Name: eth_transactions_sums_y2023m07; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eth_transactions_sums ATTACH PARTITION public.eth_transactions_sums_y2023m07 FOR VALUES FROM ('2023-07-01 00:00:00') TO ('2023-08-01 00:00:00');


--
-- Name: eth_transactions_sums_y2023m08; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eth_transactions_sums ATTACH PARTITION public.eth_transactions_sums_y2023m08 FOR VALUES FROM ('2023-08-01 00:00:00') TO ('2023-09-01 00:00:00');


--
-- Name: eth_transactions_sums_y2023m09; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eth_transactions_sums ATTACH PARTITION public.eth_transactions_sums_y2023m09 FOR VALUES FROM ('2023-09-01 00:00:00') TO ('2023-10-01 00:00:00');


--
-- Name: eth_transactions_sums_y2023m10; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eth_transactions_sums ATTACH PARTITION public.eth_transactions_sums_y2023m10 FOR VALUES FROM ('2023-10-01 00:00:00') TO ('2023-11-01 00:00:00');


--
-- Name: eth_transactions_sums_y2023m11; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eth_transactions_sums ATTACH PARTITION public.eth_transactions_sums_y2023m11 FOR VALUES FROM ('2023-11-01 00:00:00') TO ('2023-12-01 00:00:00');


--
-- Name: eth_transactions_sums_y2023m12; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eth_transactions_sums ATTACH PARTITION public.eth_transactions_sums_y2023m12 FOR VALUES FROM ('2023-12-01 00:00:00') TO ('2024-01-01 00:00:00');


--
-- Name: eth_transactions_sums_y2024m01; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eth_transactions_sums ATTACH PARTITION public.eth_transactions_sums_y2024m01 FOR VALUES FROM ('2024-01-01 00:00:00') TO ('2024-02-01 00:00:00');


--
-- Name: eth_transactions_sums_y2024m02; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eth_transactions_sums ATTACH PARTITION public.eth_transactions_sums_y2024m02 FOR VALUES FROM ('2024-02-01 00:00:00') TO ('2024-03-01 00:00:00');


--
-- Name: eth_transactions_sums_y2024m03; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eth_transactions_sums ATTACH PARTITION public.eth_transactions_sums_y2024m03 FOR VALUES FROM ('2024-03-01 00:00:00') TO ('2024-04-01 00:00:00');


--
-- Name: deprecated_blocks blocks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deprecated_blocks
    ADD CONSTRAINT blocks_pkey PRIMARY KEY (number);


--
-- Name: deprecated_contracts contracts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deprecated_contracts
    ADD CONSTRAINT contracts_pkey PRIMARY KEY (address);


--
-- Name: dune_labels dune_labels_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dune_labels
    ADD CONSTRAINT dune_labels_addresses_pkey PRIMARY KEY (address, blockchain);


--
-- Name: ens_addresses ens_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ens_addresses
    ADD CONSTRAINT ens_addresses_pkey PRIMARY KEY (address);


--
-- Name: labeled_addresses labeled_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.labeled_addresses
    ADD CONSTRAINT labeled_addresses_pkey PRIMARY KEY (address, name);


--
-- Name: deprecated_transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deprecated_transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (hash);


--
-- Name: idx_eth_transactions_sums_from_address_hash; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_eth_transactions_sums_from_address_hash ON ONLY public.eth_transactions_sums USING hash (from_address);


--
-- Name: eth_transactions_sums_y2023m01_from_address_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eth_transactions_sums_y2023m01_from_address_idx ON public.eth_transactions_sums_y2023m01 USING hash (from_address);


--
-- Name: idx_eth_transactions_sums_to_address_hash; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_eth_transactions_sums_to_address_hash ON ONLY public.eth_transactions_sums USING hash (to_address);


--
-- Name: eth_transactions_sums_y2023m01_to_address_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eth_transactions_sums_y2023m01_to_address_idx ON public.eth_transactions_sums_y2023m01 USING hash (to_address);


--
-- Name: eth_transactions_sums_y2023m02_from_address_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eth_transactions_sums_y2023m02_from_address_idx ON public.eth_transactions_sums_y2023m02 USING hash (from_address);


--
-- Name: eth_transactions_sums_y2023m02_to_address_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eth_transactions_sums_y2023m02_to_address_idx ON public.eth_transactions_sums_y2023m02 USING hash (to_address);


--
-- Name: eth_transactions_sums_y2023m03_from_address_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eth_transactions_sums_y2023m03_from_address_idx ON public.eth_transactions_sums_y2023m03 USING hash (from_address);


--
-- Name: eth_transactions_sums_y2023m03_to_address_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eth_transactions_sums_y2023m03_to_address_idx ON public.eth_transactions_sums_y2023m03 USING hash (to_address);


--
-- Name: eth_transactions_sums_y2023m04_from_address_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eth_transactions_sums_y2023m04_from_address_idx ON public.eth_transactions_sums_y2023m04 USING hash (from_address);


--
-- Name: eth_transactions_sums_y2023m04_to_address_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eth_transactions_sums_y2023m04_to_address_idx ON public.eth_transactions_sums_y2023m04 USING hash (to_address);


--
-- Name: eth_transactions_sums_y2023m05_from_address_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eth_transactions_sums_y2023m05_from_address_idx ON public.eth_transactions_sums_y2023m05 USING hash (from_address);


--
-- Name: eth_transactions_sums_y2023m05_to_address_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eth_transactions_sums_y2023m05_to_address_idx ON public.eth_transactions_sums_y2023m05 USING hash (to_address);


--
-- Name: eth_transactions_sums_y2023m06_from_address_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eth_transactions_sums_y2023m06_from_address_idx ON public.eth_transactions_sums_y2023m06 USING hash (from_address);


--
-- Name: eth_transactions_sums_y2023m06_to_address_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eth_transactions_sums_y2023m06_to_address_idx ON public.eth_transactions_sums_y2023m06 USING hash (to_address);


--
-- Name: eth_transactions_sums_y2023m07_from_address_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eth_transactions_sums_y2023m07_from_address_idx ON public.eth_transactions_sums_y2023m07 USING hash (from_address);


--
-- Name: eth_transactions_sums_y2023m07_to_address_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eth_transactions_sums_y2023m07_to_address_idx ON public.eth_transactions_sums_y2023m07 USING hash (to_address);


--
-- Name: eth_transactions_sums_y2023m08_from_address_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eth_transactions_sums_y2023m08_from_address_idx ON public.eth_transactions_sums_y2023m08 USING hash (from_address);


--
-- Name: eth_transactions_sums_y2023m08_to_address_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eth_transactions_sums_y2023m08_to_address_idx ON public.eth_transactions_sums_y2023m08 USING hash (to_address);


--
-- Name: eth_transactions_sums_y2023m09_from_address_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eth_transactions_sums_y2023m09_from_address_idx ON public.eth_transactions_sums_y2023m09 USING hash (from_address);


--
-- Name: eth_transactions_sums_y2023m09_to_address_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eth_transactions_sums_y2023m09_to_address_idx ON public.eth_transactions_sums_y2023m09 USING hash (to_address);


--
-- Name: eth_transactions_sums_y2023m10_from_address_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eth_transactions_sums_y2023m10_from_address_idx ON public.eth_transactions_sums_y2023m10 USING hash (from_address);


--
-- Name: eth_transactions_sums_y2023m10_to_address_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eth_transactions_sums_y2023m10_to_address_idx ON public.eth_transactions_sums_y2023m10 USING hash (to_address);


--
-- Name: eth_transactions_sums_y2023m11_from_address_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eth_transactions_sums_y2023m11_from_address_idx ON public.eth_transactions_sums_y2023m11 USING hash (from_address);


--
-- Name: eth_transactions_sums_y2023m11_to_address_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eth_transactions_sums_y2023m11_to_address_idx ON public.eth_transactions_sums_y2023m11 USING hash (to_address);


--
-- Name: eth_transactions_sums_y2023m12_from_address_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eth_transactions_sums_y2023m12_from_address_idx ON public.eth_transactions_sums_y2023m12 USING hash (from_address);


--
-- Name: eth_transactions_sums_y2023m12_to_address_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eth_transactions_sums_y2023m12_to_address_idx ON public.eth_transactions_sums_y2023m12 USING hash (to_address);


--
-- Name: eth_transactions_sums_y2024m01_from_address_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eth_transactions_sums_y2024m01_from_address_idx ON public.eth_transactions_sums_y2024m01 USING hash (from_address);


--
-- Name: eth_transactions_sums_y2024m01_to_address_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eth_transactions_sums_y2024m01_to_address_idx ON public.eth_transactions_sums_y2024m01 USING hash (to_address);


--
-- Name: eth_transactions_sums_y2024m02_from_address_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eth_transactions_sums_y2024m02_from_address_idx ON public.eth_transactions_sums_y2024m02 USING hash (from_address);


--
-- Name: eth_transactions_sums_y2024m02_to_address_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eth_transactions_sums_y2024m02_to_address_idx ON public.eth_transactions_sums_y2024m02 USING hash (to_address);


--
-- Name: eth_transactions_sums_y2024m03_from_address_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eth_transactions_sums_y2024m03_from_address_idx ON public.eth_transactions_sums_y2024m03 USING hash (from_address);


--
-- Name: eth_transactions_sums_y2024m03_to_address_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eth_transactions_sums_y2024m03_to_address_idx ON public.eth_transactions_sums_y2024m03 USING hash (to_address);


--
-- Name: idx_base_transaction_sums_from_address_hash; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_base_transaction_sums_from_address_hash ON public.base_transactions_sums USING hash (from_address);


--
-- Name: idx_base_transaction_sums_to_address_hash; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_base_transaction_sums_to_address_hash ON public.base_transactions_sums USING hash (to_address);


--
-- Name: idx_block_number; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_block_number ON public.deprecated_transactions USING btree (block_number);


--
-- Name: idx_ens_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ens_name ON public.ens_addresses USING btree (name);


--
-- Name: idx_from_address; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_from_address ON public.deprecated_transactions USING btree (from_address);


--
-- Name: idx_hash; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_hash ON public.deprecated_blocks USING btree (hash);


--
-- Name: idx_k3l_address_labels_address_hash; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_k3l_address_labels_address_hash ON public.k3l_address_labels USING hash (address);


--
-- Name: idx_k3l_address_labels_deduped_address_hash; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_k3l_address_labels_deduped_address_hash ON public.k3l_address_labels_deduped USING hash (address);


--
-- Name: idx_labeled_addresses_address; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_labeled_addresses_address ON public.labeled_addresses USING btree (address);


--
-- Name: idx_labels_addresses_hash_address; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_labels_addresses_hash_address ON public.dune_labels USING hash (address);


--
-- Name: idx_miner; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_miner ON public.deprecated_blocks USING btree (miner);


--
-- Name: idx_to_address; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_to_address ON public.deprecated_transactions USING btree (to_address);


--
-- Name: idx_transaction_sums_from_address; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_transaction_sums_from_address ON public.deprecated_transaction_sums USING btree (from_address);


--
-- Name: idx_transaction_sums_from_address_hash; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_transaction_sums_from_address_hash ON public.deprecated_transaction_sums USING hash (from_address);


--
-- Name: idx_transaction_sums_to_address; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_transaction_sums_to_address ON public.deprecated_transaction_sums USING btree (to_address);


--
-- Name: idx_transaction_sums_with_count_from_address; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_transaction_sums_with_count_from_address ON public.deprecated_transaction_sums_with_count USING btree (from_address);


--
-- Name: idx_transaction_sums_with_count_from_address_hash; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_transaction_sums_with_count_from_address_hash ON public.deprecated_transaction_sums_with_count USING hash (from_address);


--
-- Name: idx_transaction_sums_with_count_to_address; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_transaction_sums_with_count_to_address ON public.deprecated_transaction_sums_with_count USING btree (to_address);


--
-- Name: k3l_address_labels_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX k3l_address_labels_idx ON public.k3l_address_labels USING btree (pseudo_id);


--
-- Name: eth_transactions_sums_y2023m01_from_address_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.idx_eth_transactions_sums_from_address_hash ATTACH PARTITION public.eth_transactions_sums_y2023m01_from_address_idx;


--
-- Name: eth_transactions_sums_y2023m01_to_address_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.idx_eth_transactions_sums_to_address_hash ATTACH PARTITION public.eth_transactions_sums_y2023m01_to_address_idx;


--
-- Name: eth_transactions_sums_y2023m02_from_address_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.idx_eth_transactions_sums_from_address_hash ATTACH PARTITION public.eth_transactions_sums_y2023m02_from_address_idx;


--
-- Name: eth_transactions_sums_y2023m02_to_address_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.idx_eth_transactions_sums_to_address_hash ATTACH PARTITION public.eth_transactions_sums_y2023m02_to_address_idx;


--
-- Name: eth_transactions_sums_y2023m03_from_address_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.idx_eth_transactions_sums_from_address_hash ATTACH PARTITION public.eth_transactions_sums_y2023m03_from_address_idx;


--
-- Name: eth_transactions_sums_y2023m03_to_address_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.idx_eth_transactions_sums_to_address_hash ATTACH PARTITION public.eth_transactions_sums_y2023m03_to_address_idx;


--
-- Name: eth_transactions_sums_y2023m04_from_address_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.idx_eth_transactions_sums_from_address_hash ATTACH PARTITION public.eth_transactions_sums_y2023m04_from_address_idx;


--
-- Name: eth_transactions_sums_y2023m04_to_address_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.idx_eth_transactions_sums_to_address_hash ATTACH PARTITION public.eth_transactions_sums_y2023m04_to_address_idx;


--
-- Name: eth_transactions_sums_y2023m05_from_address_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.idx_eth_transactions_sums_from_address_hash ATTACH PARTITION public.eth_transactions_sums_y2023m05_from_address_idx;


--
-- Name: eth_transactions_sums_y2023m05_to_address_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.idx_eth_transactions_sums_to_address_hash ATTACH PARTITION public.eth_transactions_sums_y2023m05_to_address_idx;


--
-- Name: eth_transactions_sums_y2023m06_from_address_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.idx_eth_transactions_sums_from_address_hash ATTACH PARTITION public.eth_transactions_sums_y2023m06_from_address_idx;


--
-- Name: eth_transactions_sums_y2023m06_to_address_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.idx_eth_transactions_sums_to_address_hash ATTACH PARTITION public.eth_transactions_sums_y2023m06_to_address_idx;


--
-- Name: eth_transactions_sums_y2023m07_from_address_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.idx_eth_transactions_sums_from_address_hash ATTACH PARTITION public.eth_transactions_sums_y2023m07_from_address_idx;


--
-- Name: eth_transactions_sums_y2023m07_to_address_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.idx_eth_transactions_sums_to_address_hash ATTACH PARTITION public.eth_transactions_sums_y2023m07_to_address_idx;


--
-- Name: eth_transactions_sums_y2023m08_from_address_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.idx_eth_transactions_sums_from_address_hash ATTACH PARTITION public.eth_transactions_sums_y2023m08_from_address_idx;


--
-- Name: eth_transactions_sums_y2023m08_to_address_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.idx_eth_transactions_sums_to_address_hash ATTACH PARTITION public.eth_transactions_sums_y2023m08_to_address_idx;


--
-- Name: eth_transactions_sums_y2023m09_from_address_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.idx_eth_transactions_sums_from_address_hash ATTACH PARTITION public.eth_transactions_sums_y2023m09_from_address_idx;


--
-- Name: eth_transactions_sums_y2023m09_to_address_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.idx_eth_transactions_sums_to_address_hash ATTACH PARTITION public.eth_transactions_sums_y2023m09_to_address_idx;


--
-- Name: eth_transactions_sums_y2023m10_from_address_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.idx_eth_transactions_sums_from_address_hash ATTACH PARTITION public.eth_transactions_sums_y2023m10_from_address_idx;


--
-- Name: eth_transactions_sums_y2023m10_to_address_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.idx_eth_transactions_sums_to_address_hash ATTACH PARTITION public.eth_transactions_sums_y2023m10_to_address_idx;


--
-- Name: eth_transactions_sums_y2023m11_from_address_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.idx_eth_transactions_sums_from_address_hash ATTACH PARTITION public.eth_transactions_sums_y2023m11_from_address_idx;


--
-- Name: eth_transactions_sums_y2023m11_to_address_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.idx_eth_transactions_sums_to_address_hash ATTACH PARTITION public.eth_transactions_sums_y2023m11_to_address_idx;


--
-- Name: eth_transactions_sums_y2023m12_from_address_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.idx_eth_transactions_sums_from_address_hash ATTACH PARTITION public.eth_transactions_sums_y2023m12_from_address_idx;


--
-- Name: eth_transactions_sums_y2023m12_to_address_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.idx_eth_transactions_sums_to_address_hash ATTACH PARTITION public.eth_transactions_sums_y2023m12_to_address_idx;


--
-- Name: eth_transactions_sums_y2024m01_from_address_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.idx_eth_transactions_sums_from_address_hash ATTACH PARTITION public.eth_transactions_sums_y2024m01_from_address_idx;


--
-- Name: eth_transactions_sums_y2024m01_to_address_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.idx_eth_transactions_sums_to_address_hash ATTACH PARTITION public.eth_transactions_sums_y2024m01_to_address_idx;


--
-- Name: eth_transactions_sums_y2024m02_from_address_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.idx_eth_transactions_sums_from_address_hash ATTACH PARTITION public.eth_transactions_sums_y2024m02_from_address_idx;


--
-- Name: eth_transactions_sums_y2024m02_to_address_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.idx_eth_transactions_sums_to_address_hash ATTACH PARTITION public.eth_transactions_sums_y2024m02_to_address_idx;


--
-- Name: eth_transactions_sums_y2024m03_from_address_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.idx_eth_transactions_sums_from_address_hash ATTACH PARTITION public.eth_transactions_sums_y2024m03_from_address_idx;


--
-- Name: eth_transactions_sums_y2024m03_to_address_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.idx_eth_transactions_sums_to_address_hash ATTACH PARTITION public.eth_transactions_sums_y2024m03_to_address_idx;


--
-- PostgreSQL database dump complete
--

