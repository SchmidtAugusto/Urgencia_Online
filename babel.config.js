module.exports = function(api) {
  api.cache(true);

  const presets = [
    [
      '@babel/preset-env',
      {
        useBuiltIns: 'entry',
        corejs: 3,
        modules: false,
        exclude: ['transform-typeof-symbol'],
      },
    ],
  ];

  const plugins = [
    '@babel/plugin-syntax-dynamic-import',
    '@babel/plugin-transform-destructuring',
    '@babel/plugin-proposal-class-properties',
    '@babel/plugin-proposal-object-rest-spread',
    '@babel/plugin-proposal-private-methods',
    '@babel/plugin-proposal-private-property-in-object',
    [
      '@babel/plugin-transform-runtime',
      {
        helpers: false,
      },
    ],
    [
      '@babel/plugin-transform-regenerator',
      {
        async: false,
      },
    ],
  ];

  return {
    presets,
    plugins,
  };
};
