-- LABORATORY WORK 2
-- BY Kupar_Kristina

/*---------------------------------------------------------------------------
1. Вивести номер замовлення та ключ постачальника, вказавши скільки товарів даного постачальника є у даному замовленні.

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE TABLE "order"(
    num number NOT NULL,
    id_vend number NOT NULL,
    prod char(50) NOT NULL
);


CREATE TABLE vend(
    id number NOT NULL,
    name_prod char(50) NOT NULL
);

ALTER ADD CONSTRAINT "order"_pk PRIMARY KEY ('prod','id_vend');
ALTER ADD CONSTRAINT vend_pk PRIMARY KEY ('id');

ALTER ADD CONSTRAINT "order"_vend_fk FOREIGN KEY REFERENCES('id_vend', 'id');

SELECT num, id_vend FROM "order" WHERE id_vend = id;
SELECT COUNT(*) prod FROM "order", vend INNER JOIN (num, id) GROUP BY id_vend;

  

/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, що має замовлення, що містять продукти лише від 3 постачальників.

---------------------------------------------------------------------------*/

--Код відповідь:










