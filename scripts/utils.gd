extends Node
class_name Utils

static var tolerance = 0.0001 # Погрешность для сравнения значений

static func areVectorsCollinear(vec1: Vector2, vec2: Vector2):
	var dotProduct = vec1.normalized().dot(vec2.normalized())
	return abs(abs(dotProduct) - 1) < tolerance
