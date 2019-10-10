CREATE TABLE 	MM_GAME(
	game_id NUMBER(5),
	title	VARCHAR2(40),
	game_typeid NAME(2),
	game_price NUMBER(5,2),
	game_qty NUMBER(2)
	CONsTRAINT game_id_pk PRIMARY KEY (game_id),
	CONSTRAINT game_id_type 
	CONSTRAINT game_price_chk CHECK(game_price > 8)
	CONSTRAINT game_qty_chk CHECK(BETWEEN 1 AND 20) 
	-- special characters
	-- % means anything
	-- _ means one character
	-- 

);
CREATE TABLE MM_GAME_TYPE(
	game_type_id NUMBER(2),
	game_type_desc	VARCHAR2(20),
CONSTRAINT game_type_id_pk PRIMARY KEY (game_type_id)
);


CREATE TABLE MM_RENTAL (
	rental_id NUMBER(5),
	customer_id NUMBER(5),
	game_id NUMBER(5),

);

CHECK SPECIAL OPERATERS  L4 LIKE 
