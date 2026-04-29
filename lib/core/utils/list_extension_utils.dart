/// Extension utility on [List] to conditionally add elements from another list.
extension ListExtensionUtils on List {
  /// Adds elements from the given [list] to the current list
  /// if they satisfy the provided [test] condition.
  ///
  /// - [list]: The source list to iterate over.
  /// - [test]: A predicate function that returns `true` for elements
  ///   that should be added.
  ///
  /// Returns the modified list (casted as `List<T>`) after insertion.
  ///
  /// Example:
  /// ```dart
  /// final numbers = [1, 2, 3];
  /// final toAdd = [6, 7, 8, 9];
  ///
  /// numbers.addWhere(toAdd, (n) => n % 3 == 0);
  ///
  /// print(numbers); // Output: [1, 2, 3, 6, 9]
  /// ```
  List<T> addWhere<T>(List<T> list, bool Function(T element) test) {
    for (var element in list) {
      if (test(element)) {
        add(element);
      }
    }
    return this as List<T>;
  }
}
