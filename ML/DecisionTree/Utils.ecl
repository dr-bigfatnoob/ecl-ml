IMPORT ML;
IMPORT ML.Types as Types;

EXPORT Utils := MODULE

  EXPORT SplitC := ML.Trees.SplitC;
  EXPORT STRING SplitC_Fields := ML.Trees.modelC_fields;
  EXPORT SplitC_Map :=  DATASET([{'id','ID'},{'node_id','1'},{'level','2'},{'number','3'},
                                  {'value','4'},{'high_fork','5'},{'new_node_id','6'}],
                                {STRING orig_name; STRING assigned_name;});

  EXPORT SplitD := RECORD   // data structure for splitting results
    Types.NodeID;
    Types.t_FieldNumber number;       // The attribute used to split
    Types.t_FieldReal    value;        // The discrete value for the attribute in question
    Types.t_FieldReal   depend;       // Dependent value
    Types.t_node        new_node_id;  // The new node identifier this branch links to
  END;
  EXPORT STRING SplitD_Fields := 'node_id,level,number,value,depend,new_node_id';
  EXPORT SplitD_Map :=  DATASET([{'id','ID'},{'node_id','1'},{'level','2'},{'number','3'},
                                  {'value','4'},{'depend','5'},{'new_node_id','6'}],
                                {STRING orig_name; STRING assigned_name;});

  EXPORT ToNumericTree(DATASET(SplitC) nodes) := FUNCTION
    ML.AppendID(nodes, id, model);
    ML.ToField(model, out_model, id, SplitC_Fields);
    RETURN out_model;
  END;

  EXPORT ToOrdinalTree(DATASET(SplitD) nodes) := FUNCTION
    ML.AppendID(nodes, id, model);
    ML.ToField(model, out_model, id, SplitD_Fields);
    RETURN out_model;
  END;

  EXPORT ContinuousTreeNode := RECORD
    Types.NodeID;
    Types.NumericField;
    Types.t_FieldReal depend;
    BOOLEAN high_fork := FALSE;
    Types.t_Node child_id := 0;
  END;

  EXPORT CategoricalTreeNode := RECORD
    Types.NodeID;
    Types.NumericField;
    Types.t_FieldReal depend;
    Types.t_Node child_id := 0;
  END;

END;