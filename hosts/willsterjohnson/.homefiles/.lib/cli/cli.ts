import { type Awaitable, Result } from '../utilites'

type CliArgType = ['boolean', boolean] | ['string', string] | ['number', number]

interface CliArgSpec<ArgType extends CliArgType = CliArgType> {
	description: string
	defaultValue: ArgType[1] | null
	type: ArgType[0]
	required?: boolean
}

type ArgSpecType<T extends CliArgSpec> = T extends CliArgSpec<infer ArgType> ? ArgType[1] : never

type CommandArgs = { [fullName: string]: CliArgSpec }

type ParsedArgs<T extends CommandArgs> = { [fullName in keyof T]: ArgSpecType<T[fullName]> }

type Command<T extends CommandArgs = CommandArgs> = {
	action: (this: Cli, positional: string[], named: ParsedArgs<T>) => Awaitable<void>
	args: T
	description: string
	positional: {
		name: string
		description: string
		required?: boolean
	}[]
}

export class Cli {
	public constructor(
		private cliName: string,
		private commandSchema: { [commandName: string]: Command },
	) {}

	public async run(argv: string[]) {
		const commandName = argv.shift()
		if (!commandName) return this.help('Missing command name')
		if (!(commandName in this.commandSchema)) return this.help(`Unrecognized command: ${commandName}`)
		const command = this.commandSchema[commandName]
		const args = this.parseArgs(command, argv)
		if (args.isOk()) {
			const { positional, named } = args.ok().unwrap()
			await command.action.apply(this, [positional, named])
		} else this.helpCommand(commandName)
	}

	private parseArgs<T extends CommandArgs>(
		{ args, positional: positionals }: Command<CommandArgs>,
		argv: string[],
	): Result<{ positional: string[]; named: ParsedArgs<T> }, Error> {
		const parsedPositional: string[] = []
		let shouldBeOptional = false
		for (const positionalSpec of positionals) {
			if (!positionalSpec.required) shouldBeOptional = true
			else if (shouldBeOptional)
				return Result.Err(`Required argument ${positionalSpec.name} after optional argument`)
			const positionalValue = argv.shift()
			if (!positionalValue) return Result.Err(`Missing positional argument: ${positionalSpec.name}`)
			if (positionalValue.startsWith('--')) {
				if (shouldBeOptional) break
				return Result.Err(`Missing positional argument: ${positionalSpec.name}`)
			}
			parsedPositional.push(positionalValue)
		}
		const parsedArgs: Record<string, string | number | boolean | null> = {}
		while (argv.length) {
			let argName = argv.shift()
			if (!argName) break
			argName = argName.replace(/^--/, '')
			if (!(argName in args)) return Result.Err(`Unknown argument: ${argName}`)
			const arg = args[argName]
			if (arg.type === 'boolean') {
				parsedArgs[argName] = arg.defaultValue
				continue
			}
			const argValue = argv.shift()
			if (!argValue) return Result.Err(`Missing value for argument: ${argName}`)
			if (arg.type === 'number') {
				const parsedValue = parseFloat(argValue)
				if (isNaN(parsedValue)) return Result.Err(`Invalid number: ${argValue}`)
				parsedArgs[argName] = parsedValue
			} else parsedArgs[argName] = argValue
		}
		for (const argName in args) {
			if (argName in parsedArgs) continue
			const arg = args[argName]
			parsedArgs[argName as string] = arg.defaultValue
		}
		return Result.Ok({ positional: parsedPositional, named: parsedArgs as ParsedArgs<T> })
	}

	private params(command: Command) {
		let params = ''
		for (const positional of command.positional) {
			if (positional.required) params += ` <${positional.name}>`
			else params += ` [${positional.name}]`
		}
		return `${params} [OPTIONS...]`
	}

	private help(errorMessage?: string) {
		if (errorMessage) console.error(errorMessage)
		console.log()
		console.log(`Usage: ${this.cliName} <command> [args]`)
		console.log('Commands:')
		for (const commandName in this.commandSchema) {
			const command = this.commandSchema[commandName]
			console.log(`\t${commandName} ${this.params(command)}`)
			console.log(`\t\t${command.description}`)
		}
	}

	private helpCommand(commandName: string) {
		const command = this.commandSchema[commandName]
		console.log()
		console.log(`Usage: ${this.cliName} ${commandName} ${this.params(command)}`)
		console.log()
		console.log('Positional arguments:')
		for (const positional of command.positional) console.log(`\t${positional.name}\t${positional.description}`)
		console.log()
		console.log('Options:')
		for (const argName in command.args) {
			const arg = command.args[argName]
			console.log(`\t--${argName}\t${arg.description}`)
		}
	}
}
