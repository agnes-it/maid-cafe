const custom = require('../webpack.config.js')(null, {});

module.exports = {
  stories: ['../src/components/**/*.stories.js'],
  addons: ['@storybook/addon-actions', '@storybook/addon-links'],
  webpackFinal: async config => {
    // do mutation to the config
    
    return {
      ...config,
      module: {
        ...config.module,
        rules: [ ...custom.module.rules ],
      },
    };
  },
};
