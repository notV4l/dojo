use std::sync::Arc;

use jsonrpsee::core::async_trait;
use katana_core::sequencer::KatanaSequencer;
use katana_rpc_types::account::Account;
use serde_json::Value;


#[derive(Clone)]
pub struct HttpApi {
    sequencer: Arc<KatanaSequencer>,
}

impl HttpApi {
    pub fn new(sequencer: Arc<KatanaSequencer>) -> Self {
        Self { sequencer }
    }
}
#[async_trait]
pub trait HttpApiServer {
    fn health(&self) -> Value;
    fn predeployed_accounts(&self) -> Value;
}

#[async_trait]
impl HttpApiServer for HttpApi {
    fn health(&self) -> Value {
        serde_json::json!({ "health": true })
    }

    fn predeployed_accounts(&self) -> Value {
       let accounts: Vec<Account> = self
        .sequencer
        .backend()
        .config
        .genesis
        .accounts()
        .map(|e| Account::new(*e.0, e.1))
        .collect();
       
        serde_json::json!(accounts)
    }
}
