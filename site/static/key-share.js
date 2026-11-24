// Share a Kaiwa AI key inside an invite link, with no server.
//
// The mechanism is link-core (KakkoiDev/link-core, vendored as ./link-core.js;
// Echo uses the same library). This file holds only Kaiwa's choices:
//
//   - the associated data is 'minihongo-kaiwa-key-v1', forever: every invite
//     already sent was sealed with it, and a link sealed for another app
//     never opens here;
//   - the token travels after '#key=';
//   - an invite must carry a provider and a key.
//
// The unlock code never goes into the link. Expiry is enforced by the app
// only. See link-core's README for the threat model.
import {
  sealLink,
  openLink,
  readLinkToken,
  isLinkSupported,
  normalizeUnlockCode,
  LinkError,
} from './link-core.js?v={{CACHE_HASH}}'

const APP = 'minihongo-kaiwa-key-v1'

// payload: { provider, key, speechKey? }; days: number or 0 for no expiry.
// Returns { token, code } - token goes after '#key=', code is shown to the sender.
const sealKey = (payload, days = 0) => sealLink(payload, { app: APP, days })

const readToken = (hash = location.hash) => readLinkToken(hash, 'key')

const openKey = (token, code) => openLink(token, code, { app: APP, accept: body => !!(body?.provider && body?.key) })

window.MinihongoKeyShare = {
  sealKey,
  openKey,
  readToken,
  isSupported: isLinkSupported,
  normalizeUnlockCode,
  KeyShareError: LinkError,
}
