export const copy = (source: object, target: object) => {
  Object.keys(source).forEach((key) => {
    target[key] = source[key]
  })
}
