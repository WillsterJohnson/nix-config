import { panic } from './panic'

interface _Option<T> {
	isSome(): boolean
	isNone(): boolean
	unwrap(): T
}

interface Some<T> extends _Option<T> {
	isSome(): this is Some<T>
	isNone(): false
}

interface None extends _Option<never> {
	isSome(): false
	isNone(): this is None
}

export type Option<T> = Some<T> | None
export const Option = {
	Some: <T>(value: T): Option<T> => ({
		isSome: (): this is Some<T> => true,
		isNone: () => false,
		unwrap: () => value,
	}),
	None: (): Option<never> => ({
		isSome: () => false,
		isNone: (): this is None => true,
		unwrap: () => panic('Option is None'),
	}),
}
