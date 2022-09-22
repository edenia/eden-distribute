const eosUtil = require('./utils/eos.util')
const { eosConfig } = require('./config')

const edenAccount = eosConfig.edenAccount
const distribute = eosConfig.distributeAccount
const distributePerms = eosConfig.distributePerms
const max_steps = eosConfig.distributeMaxSteps

async function init() {
  let retry = true
  try {
    while ( retry ) {
      console.log('Calling distribute action on Eden Account:', edenAccount)

      const transact = await eosUtil
        .transact([
          {
            account: edenAccount,
            name: 'distribute',
            authorization: [{ actor: distribute, permission: distributePerms }],
            data: {
              max_steps
            }
          }
        ])
        .catch(er => {
          retry = false
          console.log(er.toString())
        })

      if (transact) {console.log(transact)}
      
    }
  } catch (error) {
    console.error(error)
  }
}
init()
