-- 1 - Crie a tabela ResumoVendasProdutos(id_prod, qtd_vendas, valor_total_vendido);

CREATE TABLE ResumoVendasProdutos (
    id_prod INT,
    qtd_vendas INT,
    valor_total_vendido DECIMAL(10, 2)
);

-- Foi preciso também criar a table vendas para que a trigger funcionasse.

CREATE TABLE vendas (
    id_prod INT,
    valor DECIMAL(10, 2)
);

-- 2 - Altere a trigger que executa após a inserção em vendas de forma que ela também atualize a tabela ResumoVendasProdutos.

CREATE OR REPLACE FUNCTION atualizar_resumo_vendas()
    RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se o registro já existe na tabela ResumoVendasProdutos
    IF EXISTS (SELECT 1 FROM ResumoVendasProdutos WHERE id_prod = NEW.id_prod) THEN
        -- Atualiza a quantidade de vendas e o valor total vendido
        UPDATE ResumoVendasProdutos
        SET qtd_vendas = qtd_vendas + 1,
            valor_total_vendido = valor_total_vendido + NEW.valor
        WHERE id_prod = NEW.id_prod;
    ELSE
        -- Insere um novo registro na tabela ResumoVendasProdutos
        INSERT INTO ResumoVendasProdutos (id_prod, qtd_vendas, valor_total_vendido)
        VALUES (NEW.id_prod, 1, NEW.valor);
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER atualizar_resumo_vendas_trigger
AFTER INSERT ON vendas
FOR EACH ROW
EXECUTE FUNCTION atualizar_resumo_vendas();

-- 3 - Crie uma função imprimir_vendas(id_prod) que recebe o id do produto e imprime as informações das vendas relacionadas àquele produto. Use cursores para percorrer as tuplas que 

-- serão impressas.

CREATE OR REPLACE FUNCTION imprimir_vendas(id_prod INT)
    RETURNS VOID AS $$
DECLARE
    produto RECORD;
    vendas_produto CURSOR FOR SELECT * FROM vendas WHERE id_prod = id_prod;
BEGIN
    OPEN vendas_produto;
    LOOP
        FETCH vendas_produto INTO produto;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE 'Produto: %, Valor: %', produto.id_prod, produto.valor;
    END LOOP;
    CLOSE vendas_produto;
END;
$$ LANGUAGE plpgsql;
