module.exports = {
  endpoint: process.env.EOS_API_ENDPOINT,
  chainId: process.env.EOS_API_CHAIN_ID,
  distributeAccount: process.env.EOS_DISTRIBUTE_ACCOUNT,
  distributePerms: process.env.EOS_DISTRIBUTE_PERMISSION,
  distributeMaxSteps: process.env.EOS_DISTRIBUTE_MAX_STEPS,
  pvtKey: process.env.EOS_DISTRIBUTE_PRIVATE_KEY,
  edenAccount: process.env.EOS_EDEN_ACCOUNT
}
