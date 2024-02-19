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
-- Name: contracts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contracts (
    address character varying(42) NOT NULL,
    is_erc20 boolean NOT NULL,
    is_erc721 boolean NOT NULL
);


ALTER TABLE public.contracts OWNER TO postgres;

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
);


ALTER TABLE public.eth_transactions_sums OWNER TO postgres;

--
-- Name: ethereum_addresses_with_token_standards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ethereum_addresses_with_token_standards (
    contract_address character varying(42) NOT NULL,
    token_standard character varying NOT NULL
);


ALTER TABLE public.ethereum_addresses_with_token_standards OWNER TO postgres;

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
-- Name: optimism_addresses_with_token_standards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.optimism_addresses_with_token_standards (
    contract_address character varying(42) NOT NULL,
    token_standard character varying NOT NULL
);


ALTER TABLE public.optimism_addresses_with_token_standards OWNER TO postgres;

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
-- Name: transaction_sums; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transaction_sums (
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


ALTER TABLE public.transaction_sums OWNER TO postgres;

--
-- Name: transaction_sums_with_count; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transaction_sums_with_count (
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


ALTER TABLE public.transaction_sums_with_count OWNER TO postgres;

--
-- Name: deprecated_blocks blocks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deprecated_blocks
    ADD CONSTRAINT blocks_pkey PRIMARY KEY (number);


--
-- Name: contracts contracts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contracts
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
-- Name: idx_eth_transactions_sums_from_address_hash; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_eth_transactions_sums_from_address_hash ON public.eth_transactions_sums USING hash (from_address);


--
-- Name: idx_eth_transactions_sums_to_address_hash; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_eth_transactions_sums_to_address_hash ON public.eth_transactions_sums USING hash (to_address);


--
-- Name: idx_from_address; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_from_address ON public.deprecated_transactions USING btree (from_address);


--
-- Name: idx_hash; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_hash ON public.deprecated_blocks USING btree (hash);


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

CREATE INDEX idx_transaction_sums_from_address ON public.transaction_sums USING btree (from_address);


--
-- Name: idx_transaction_sums_from_address_hash; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_transaction_sums_from_address_hash ON public.transaction_sums USING hash (from_address);


--
-- Name: idx_transaction_sums_to_address; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_transaction_sums_to_address ON public.transaction_sums USING btree (to_address);


--
-- Name: idx_transaction_sums_with_count_from_address; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_transaction_sums_with_count_from_address ON public.transaction_sums_with_count USING btree (from_address);


--
-- Name: idx_transaction_sums_with_count_from_address_hash; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_transaction_sums_with_count_from_address_hash ON public.transaction_sums_with_count USING hash (from_address);


--
-- Name: idx_transaction_sums_with_count_to_address; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_transaction_sums_with_count_to_address ON public.transaction_sums_with_count USING btree (to_address);


--
-- PostgreSQL database dump complete
--

