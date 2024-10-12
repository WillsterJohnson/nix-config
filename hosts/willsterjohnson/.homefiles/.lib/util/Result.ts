import { panic } from './panic'

interface _Result<T, E> {
	/**
	 * @returns true if the result is Ok
	 */
	isOk(): boolean
	/**
	 * @returns true if the result is Err
	 */
	isErr(): boolean
	/**
	 * @returns the value if the result is Ok
	 * @throws if the result is Err - check with {@link isOk} first
	 */
	ok(): T
	/**
	 * @returns the error if the result is Err
	 * @throws if the result is Ok - check with {@link isErr} first
	 */
	err(): E
}

interface Ok<T> extends _Result<T, never> {
	isOk(): this is Ok<T>
	isErr(): false
}

interface Err<E> extends _Result<never, E> {
	isOk(): false
	isErr(): this is Err<E>
}

type ErrType<E> = E extends string ? Error : E

export type Result<T, E> = Ok<T> | Err<E>
export const Result = {
	Ok: <T>(value: T): Result<T, never> => ({
		isOk: (): this is Ok<T> => true,
		isErr: () => false,
		ok: () => value,
		err: () => panic('Result is Err'),
	}),
	Err: <E>(error: E): Result<never, ErrType<E>> => ({
		isOk: () => false,
		isErr: (): this is Err<ErrType<E>> => true,
		ok: () => panic('Result is Ok'),
		err: () => (typeof error === 'string' ? new Error(error) : error) as ErrType<E>,
	}),
}
