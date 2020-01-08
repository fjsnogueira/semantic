-- | Semantic functionality for Python programs.
module Language.Python
( Term(..)
, TreeSitter.Python.tree_sitter_python
) where

import qualified Language.Python.Tags as PyTags
import qualified Language.Python.ScopeGraph as PyScopeGraph
import qualified Tags.Tagging.Precise as Tags
import qualified Data.ScopeGraph as ScopeGraph
import qualified TreeSitter.Python (tree_sitter_python)
import qualified TreeSitter.Python.AST as Py
import qualified TreeSitter.Unmarshal as TS

newtype Term a = Term { getTerm :: Py.Module a }

instance TS.Unmarshal Term where
  unmarshalNode node = Term <$> TS.unmarshalNode node

instance Tags.ToTags Term where
  tags src = Tags.runTagging src . PyTags.tags . getTerm


instance ScopeGraph.ToScopeGraph Term where
  scopeGraph src = ScopeGraph.runScopeGraph src . PyScopeGraph.scopeGraph . getTerm
