import { $ } from 'bun'
import { join } from 'node:path'
import { type JsonSerializable } from '../.lib/util/types'

const argv = Bun.argv.slice(2)
const obsidianHome = join(Bun.env.HOME!, '.config', 'obsidian')
const obsidianJsonPath = join(obsidianHome, 'obsidian.json')
const vaultsPath = argv.shift()!

class Obsidian {
	private static async exec(action: string, params: Record<string, string>) {
		$`obsidian obsidian://${action}?${Object.entries(params)
			.map(([key, value]) => `${key}=${value}`)
			.join('&')} &>/dev/null &`
	}
	public static async open(data: { vault: string; file?: string } | { path: string }) {
		await this.exec('open', data)
	}
}

class ObsidianJson {
	private data!: JsonSerializable
	private constructor() {}
	public static async create() {
		const oJson = new ObsidianJson()
		if (!Bun.file(obsidianJsonPath).exists()) Bun.write(obsidianJsonPath, JSON.stringify({}, null, 2))
		oJson.data = await Bun.file(obsidianJsonPath).json()
	}
}
