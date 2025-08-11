abstract class UseCase<T, U> {
  const UseCase();

  T call(U parameter);
}
