CREATE flow dismus:
\cw dismus

begin ;

CREATE wed-attribute Usuário_ID, Usuário_Status, Conta_ID, Conta_status,Data_Última_Assinatura, Pagamento_status, Lista_ID, Lista_status;


CREATE Wed-condition Contrata as Pagamentos_status = pago and Usuário_Tipo = 'Titular';

CREATE Wed-condition Anula_contrato as Data_Última_Assinatura < (Today - 1 year);

CREATE Wed-condition Listas_Remover as Conta_status = 'grátis' and Lista_ID not null;

CREATE Wed-condition Usuário_removido as Usuário_Tipo = 'comum' and Usuário_Status = 'Removido';

CREATE Wed-condition Usuário_Titular_removido as Usuário_Tipo = 'Titular' and Usuário_Status = 'Removido';



CREATE Wed-transition Contrato_anulado;

CREATE Wed-transition Remover_Listas;

CREATE Wed-transition Assinatura_Contratada;

CREATE Wed-transition Remover_Usuário;

CREATE Wed-transition Remover_Conta;



CREATE Wed-trigger A (Contrata,Assinatura_Contratada);

CREATE Wed-trigger B (Anula_contrato,Contrato_anulado);

CREATE Wed-trigger C (Listas_Remover,Remover_Listas);

CREATE Wed-trigger D (Usuário_removido,Remover_Usuário);

CREATE Wed-trigger E (Usuário_removido,Remover_Listas);

CREATE Wed-trigger F (Usuário_Titular_removido,Remover_Usuário);

CREATE Wed-trigger G (Usuário_Titular_removido,Remover_Listas);

CREATE Wed-trigger H (Usuário_Titular_removido,Remover_Conta);



Set final wed-state as Usuário_Tipo = 'Titular' and Usuário_Status = 'Removido' and Conta_Status = 'Removida' and Lista_Status = 'Removida';


commit;
