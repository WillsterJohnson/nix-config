export type Arrayable<T> = T | T[]

export type MaybeArray<Element, Condition extends boolean> = Condition extends true ? Element[] : Element

export type Awaitable<T> = T | Promise<T>

export function nullish(value: unknown): value is null | undefined {
	return (value ?? null) === null
}

export function callSafe<T extends any[], R>(fallback: R, callback: ((...args: T) => R) | undefined, args: T) {
	if (callback) return callback(...args)
	return fallback
}

class _Option<T> {
	protected constructor(private value: T | null = null) {}

	public isSome<U extends T>(predicate?: (value: T) => this is Option<U>): this is Option<U> {
		return this.value !== null && callSafe(true, predicate, [this.value])
	}

	public isNone<U extends T | null = null>(predicate?: (value: T) => this is Option<U>): this is Option<U> {
		return this.value === null || callSafe(true, predicate, [this.value])
	}

	public unwrap() {
		if (this.value === null) throw new Error('Option is None')
		return this.value
	}
}
class Some<T> extends _Option<T> {}
class None extends _Option<any> {}
export class Option<T> extends _Option<T | null> {
	public static Some<T>(value: T) {
		return new Some<T>(value)
	}
	public static get None() {
		return new None()
	}
	public static from<T>(value: T | undefined | null) {
		return (nullish(value) ? Option.None : Option.Some(value)) as Option<T>
	}
}

class _Result<T, E> {
	protected constructor(
		private value: T,
		private error: E,
	) {}

	public isOk<U extends T>(predicate?: (value: T) => value is U): this is Ok<U> {
		return this.value !== null && callSafe(true, predicate, [this.value as T])
	}

	public isErr<U extends E>(predicate?: (error: E) => error is U): this is Err<U> {
		return this.value === null && callSafe(true, predicate, [this.error as E])
	}

	public ok(): Option<T> {
		return Option.Some<T>(this.value)
	}

	public err(): Option<E> {
		return Option.Some<E>(this.error)
	}
}
class Ok<T> extends _Result<T, any> {
	constructor(value: T) {
		super(value, null)
	}
}
class Err<E> extends _Result<any, E> {
	constructor(error: E) {
		super(null, error)
	}
}
type AnyNonError = Exclude<any, Error>
export class Result<T, E> extends _Result<T, E> {
	public static Ok<T>(value: T) {
		return new Ok(value)
	}
	public static Err<E extends Error>(error: E): Err<E>
	public static Err(error: string): Err<Error>
	public static Err<E extends Error>(error: E | string) {
		if (!(error instanceof Error)) return new Err<Error>(new Error(error))
		return new Err<E>(error)
	}
}
