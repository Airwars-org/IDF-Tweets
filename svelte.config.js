import adapter from '@sveltejs/adapter-static';
// import adapter from '@sveltejs/adapter-auto';

/** @type {import('@sveltejs/kit').Config} */
const config = {
	kit: {
		adapter: adapter(
			{
				pages: 'build',
				assets: 'build',
				fallback: null,
				precompress: false
			}
		),
		paths: {
			base: ''
		},
		alias: {
			'@components': 'src/lib/components',
			'@stores': 'src/lib/stores',
			'@lib': 'src/lib',
		}
	}
};

export default config;
