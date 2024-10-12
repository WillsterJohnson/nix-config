import { $ } from 'bun'
import { join } from 'node:path'
import { Cli } from '../.lib/cli/cli'

const argv = Bun.argv.slice(2)
const obsidianHome = join(Bun.env.HOME!, '.config', 'obsidian')
const obsidianJsonPath = join(obsidianHome, 'obsidian.json')
const vaultsPath = argv.shift()!

new Cli('vault', {
	list: {
		args: {},
		description: 'List vaults',
		positional: [
			{
				name: 'search',
				description: 'Search query',
			},
		],
		async action() {
			const data = (await Bun.file(obsidianJsonPath).json()) as { vaults: { [uuid: string]: { path: string } } }
			if (!Object.keys(data.vaults).length) return console.log('No vaults')
			for (const [uuid, { path }] of Object.entries(data.vaults)) console.log(`\t${uuid}\t${path}`)
		},
	},
	open: {
		args: {
			vault: {
				type: 'string',
				defaultValue: null,
				description: 'Vault to open - either a uuid or path',
				required: true,
			},
			file: {
				type: 'string',
				defaultValue: null,
				description: 'File to open - a path',
			},
		},
		description: 'Open a vault',
		positional: [],
		async action(_, named) {
			const params = Object.entries(named)
				.map(([key, value]) => `${key}=${value}`)
				.join('&')
			await $`obsidian "obsidian://open?${params}" &>/dev/null`
		},
	},
	create: {
		args: {},
		description: 'Create a vault',
		positional: [
			{
				name: 'name',
				description: `Name of the vault. Created in '${Bun.env.HOME}/Vaults'`,
				required: true,
			},
		],
		async action([name]) {
			const uuid = crypto.randomUUID().replace(/-/g, '')
			const target = join(vaultsPath, name)

			const obsidianJson = await Bun.file(obsidianJsonPath).json()
			obsidianJson.vaults[uuid] = { path: target, ts: Date.now(), open: true }
			await Bun.write(obsidianJsonPath, JSON.stringify(obsidianJson))

			const vaultJson = { x: 0, y: 0, width: 1920, height: 1080, isMaximized: true, devTools: false, zoom: 0 }
			const vaultJsonPath = join(Bun.env.HOME!, '.config', 'obsidian', `${uuid}.json`)
			await Bun.write(vaultJsonPath, JSON.stringify(vaultJson))

			await this.run(['open', '--vault', uuid])
		},
	},
}).run(argv)
