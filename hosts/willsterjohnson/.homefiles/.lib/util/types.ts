export type nullish = null | undefined | void
export type Nullish<T> = T extends nullish ? T : never
export function isNullish(value: unknown): value is nullish
export function isNullish<T>(value: T): value is Nullish<T>
export function isNullish<T>(value: T): boolean {
	return (value ?? null) === null
}

export type defined = string | number | boolean | object | symbol | bigint | Function
export type Defined<T> = T extends defined ? T : never
export function isDefined(value: unknown): value is defined
export function isDefined<T>(value: T): value is Defined<T>
export function isDefined<T>(value: T): boolean {
	return (value ?? null) !== null
}

export type Arrayable<T> = T | T[]

export type MaybeArray<Item, Clause extends boolean> = Clause extends true ? Item[] : Item

export type Awaitable<T> = T | Promise<T>

export type Constructor<T = unknown> = new (...args: any[]) => T
