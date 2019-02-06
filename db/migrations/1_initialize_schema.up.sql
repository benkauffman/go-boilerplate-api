 -- Table: category
CREATE TABLE category (
    id int NOT NULL AUTO_INCREMENT,
    display varchar(20) NOT NULL,
    CONSTRAINT category_pk PRIMARY KEY (id)
);

-- Table: color
CREATE TABLE color (
    id bigint NOT NULL AUTO_INCREMENT,
    display varchar(50) NOT NULL,
    UNIQUE INDEX color_ak_1 (display),
    CONSTRAINT color_pk PRIMARY KEY (id)
);

-- Table: colors
CREATE TABLE colors (
    color_id bigint NOT NULL,
    style_color_code_id varchar(10) NOT NULL,
    CONSTRAINT colors_pk PRIMARY KEY (color_id,style_color_code_id)
);

-- Table: condition
CREATE TABLE `condition` (
    id int NOT NULL AUTO_INCREMENT,
    display varchar(20) NOT NULL,
    CONSTRAINT condition_pk PRIMARY KEY (id)
);

-- Table: discount
CREATE TABLE discount (
    style_color_code_id varchar(10) NOT NULL,
    condition_id int NOT NULL,
    percentage decimal(2,2) NOT NULL,
    CONSTRAINT discount_pk PRIMARY KEY (style_color_code_id)
);

-- Table: gender
CREATE TABLE gender (
    id int NOT NULL AUTO_INCREMENT,
    display varchar(20) NOT NULL,
    CONSTRAINT gender_pk PRIMARY KEY (id)
);

-- Table: inventory
CREATE TABLE inventory (
    rack varchar(2) NOT NULL,
    level int NOT NULL,
    tote int NOT NULL,
    postion int NOT NULL,
    unit_level_tag_id varchar(10) NULL,
    filled datetime NULL,
    emptied datetime NULL,
    CONSTRAINT inventory_pk PRIMARY KEY (rack,level,tote,postion)
);

-- Table: shopify
CREATE TABLE shopify (
    unit_level_tag_id varchar(10) NOT NULL,
    product_id int NOT NULL,
    variant_id int NOT NULL,
    handle varchar(250) NOT NULL,
    CONSTRAINT shopify_pk PRIMARY KEY (unit_level_tag_id)
);

-- Table: size
CREATE TABLE size (
    style_color_code_id varchar(10) NOT NULL,
    upc varchar(14) NOT NULL,
    code double(3,1) NOT NULL,
    sort int NULL,
    CONSTRAINT size_pk PRIMARY KEY (style_color_code_id,upc)
);

-- Table: status
CREATE TABLE status (
    unit_level_tag_id varchar(10) NOT NULL,
    field varchar(100) NOT NULL,
    changed_at datetime NOT NULL DEFAULT NOW(),
    user_id int NULL,
    CONSTRAINT status_pk PRIMARY KEY (unit_level_tag_id,field,changed_at)
);

-- Table: style_color_code
CREATE TABLE style_color_code (
    id varchar(10) NOT NULL,
    gender_id int NOT NULL,
    title varchar(100) NOT NULL,
    description varchar(10000) NOT NULL,
    no_fly bool NOT NULL,
    product_start datetime NOT NULL,
    product_end datetime NULL,
    price_msrp int NOT NULL,
    price_wholesale int NULL,
    category_primary varchar(100) NOT NULL,
    category_sub varchar(100) NOT NULL,
    color_description varchar(100) NOT NULL,
    primary_category_id int NULL,
    secondary_category_id int NULL,
    CONSTRAINT style_color_code_pk PRIMARY KEY (id)
);

-- Table: unit_level_tag
CREATE TABLE unit_level_tag (
    id varchar(10) NOT NULL,
    style_color_code_id varchar(10) NOT NULL,
    upc varchar(14) NOT NULL,
    rejected varchar(100) NULL,
    size_unisex double(3,1) NOT NULL,
    price int NOT NULL,
    created_at datetime NOT NULL DEFAULT NOW(),
    updated_at datetime NOT NULL DEFAULT NOW(),
    deleted_at datetime NULL,
    initial_condition_id int NOT NULL,
    final_condition_id int NULL,
    CONSTRAINT unit_level_tag_pk PRIMARY KEY (id)
);

-- Table: user
CREATE TABLE user (
    id int NOT NULL,
    name varchar(100) NOT NULL,
    created_at datetime NOT NULL DEFAULT NOW(),
    updated_at datetime NOT NULL DEFAULT NOW(),
    deleted_at datetime NULL,
    CONSTRAINT user_pk PRIMARY KEY (id)
);

-- Table: versioned_ult
CREATE TABLE versioned_ult (
    id bigint NOT NULL AUTO_INCREMENT,
    user_id int NOT NULL,
    unit_level_tag_id varchar(10) NOT NULL,
    application varchar(100) NOT NULL,
    action varchar(100) NOT NULL,
    data json NULL,
    created_at datetime NOT NULL,
    CONSTRAINT versioned_ult_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: Table_18_style_color_code (table: discount)
ALTER TABLE discount ADD CONSTRAINT Table_18_style_color_code FOREIGN KEY Table_18_style_color_code (style_color_code_id)
    REFERENCES style_color_code (id);

-- Reference: colors_color (table: colors)
ALTER TABLE colors ADD CONSTRAINT colors_color FOREIGN KEY colors_color (color_id)
    REFERENCES color (id);

-- Reference: colors_style_color_code (table: colors)
ALTER TABLE colors ADD CONSTRAINT colors_style_color_code FOREIGN KEY colors_style_color_code (style_color_code_id)
    REFERENCES style_color_code (id);

-- Reference: discount_condition (table: discount)
ALTER TABLE discount ADD CONSTRAINT discount_condition FOREIGN KEY discount_condition (condition_id)
    REFERENCES `condition` (id);

-- Reference: history_unit_level_tag (table: versioned_ult)
ALTER TABLE versioned_ult ADD CONSTRAINT history_unit_level_tag FOREIGN KEY history_unit_level_tag (unit_level_tag_id)
    REFERENCES unit_level_tag (id);

-- Reference: history_user (table: versioned_ult)
ALTER TABLE versioned_ult ADD CONSTRAINT history_user FOREIGN KEY history_user (user_id)
    REFERENCES user (id);

-- Reference: inventory_unit_level_tag (table: inventory)
ALTER TABLE inventory ADD CONSTRAINT inventory_unit_level_tag FOREIGN KEY inventory_unit_level_tag (unit_level_tag_id)
    REFERENCES unit_level_tag (id);

-- Reference: shopify_unit_level_tag (table: shopify)
ALTER TABLE shopify ADD CONSTRAINT shopify_unit_level_tag FOREIGN KEY shopify_unit_level_tag (unit_level_tag_id)
    REFERENCES unit_level_tag (id);

-- Reference: size_style_color_code (table: size)
ALTER TABLE size ADD CONSTRAINT size_style_color_code FOREIGN KEY size_style_color_code (style_color_code_id)
    REFERENCES style_color_code (id);

-- Reference: style_color_code_gender (table: style_color_code)
ALTER TABLE style_color_code ADD CONSTRAINT style_color_code_gender FOREIGN KEY style_color_code_gender (gender_id)
    REFERENCES gender (id);

-- Reference: style_color_code_primary_category (table: style_color_code)
ALTER TABLE style_color_code ADD CONSTRAINT style_color_code_primary_category FOREIGN KEY style_color_code_primary_category (primary_category_id)
    REFERENCES category (id);

-- Reference: style_color_code_secondary_category (table: style_color_code)
ALTER TABLE style_color_code ADD CONSTRAINT style_color_code_secondary_category FOREIGN KEY style_color_code_secondary_category (secondary_category_id)
    REFERENCES category (id);

-- Reference: tracking_unit_level_tag (table: status)
ALTER TABLE status ADD CONSTRAINT tracking_unit_level_tag FOREIGN KEY tracking_unit_level_tag (unit_level_tag_id)
    REFERENCES unit_level_tag (id);

-- Reference: tracking_user (table: status)
ALTER TABLE status ADD CONSTRAINT tracking_user FOREIGN KEY tracking_user (user_id)
    REFERENCES user (id);

-- Reference: unit_level_tag_final_condition (table: unit_level_tag)
ALTER TABLE unit_level_tag ADD CONSTRAINT unit_level_tag_final_condition FOREIGN KEY unit_level_tag_final_condition (final_condition_id)
    REFERENCES `condition` (id);

-- Reference: unit_level_tag_initial_condition (table: unit_level_tag)
ALTER TABLE unit_level_tag ADD CONSTRAINT unit_level_tag_initial_condition FOREIGN KEY unit_level_tag_initial_condition (initial_condition_id)
    REFERENCES `condition` (id);

-- Reference: unit_level_tag_size (table: unit_level_tag)
ALTER TABLE unit_level_tag ADD CONSTRAINT unit_level_tag_size FOREIGN KEY unit_level_tag_size (style_color_code_id,upc)
    REFERENCES size (style_color_code_id,upc);

-- End of file.

