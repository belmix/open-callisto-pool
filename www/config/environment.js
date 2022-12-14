/* jshint node: true */

module.exports = function(environment) {
  var ENV = {
    modulePrefix: 'open-social-pool',
    environment: environment,
    rootURL: '/',
    locationType: 'hash',
    EmberENV: {
      FEATURES: {
        // Here you can enable experimental features on an ember canary build
        // e.g. 'with-controller': true
      }
    },

    APP: {
      // API host and port
      ApiUrl: '//clo.yourdomain.net/',
      PoolName: 'CLO Pool',
      CompanyName: 'yourdomain.net',
      // HTTP mining endpoint
      HttpHost: 'https://clo.yourdomain.net',
      HttpPort: 8882,

      // Stratum mining endpoint
      StratumHost: 'mystratumname.yourdomain.net:',
      StratumPort: 8002,

      // Fee and payout details
      PoolFee: '0.5%',
      PayoutThreshold: '1.0',
      PayoutInterval: '3h',

      // For network hashrate (change for your favourite fork)
      BlockTime: 14.4,
      BlockReward: 420,
      Unit: 'CLO',

    }
  };

  if (environment === 'development') {
    /* Override ApiUrl just for development, while you are customizing
      frontend markup and css theme on your workstation.
    */
    ENV.APP.ApiUrl = 'http://localhost:8080/'
    // ENV.APP.LOG_RESOLVER = true;
    // ENV.APP.LOG_ACTIVE_GENERATION = true;
    // ENV.APP.LOG_TRANSITIONS = true;
    // ENV.APP.LOG_TRANSITIONS_INTERNAL = true;
    // ENV.APP.LOG_VIEW_LOOKUPS = true;
  }

  if (environment === 'test') {
    // Testem prefers this...
    ENV.locationType = 'none';

    // keep test console output quieter
    ENV.APP.LOG_ACTIVE_GENERATION = false;
    ENV.APP.LOG_VIEW_LOOKUPS = false;

    ENV.APP.rootElement = '#ember-testing';
  }

  if (environment === 'production') {

  }

  return ENV;
};
