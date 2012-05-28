# Triangle Project Code.

# Triangle analyzes the lengths of the sides of a triangle
# (represented by a, b and c) and returns the type of triangle.
#
# It returns:
#   :equilateral  if all sides are equal
#   :isosceles    if exactly 2 sides are equal
#   :scalene      if no sides are equal
#
# The tests for this method can be found in
#   about_triangle_project.rb
# and
#   about_triangle_project_2.rb
#

# trying to be fancy here
# def triangle(*args)
# splat for an array just because
#
# sides = args.is_a?(Array) ? args : args.to_a
# do an interesection, result is a count of unequal sides
# unequal_sides = (sides & sides).length

def triangle(a, b, c)
	# triangle error handling		
	raise TriangleError, "Sides must be greater than zero." if a <= 0 || b <= 0 || c <= 0
	raise TriangleError, "Sum of two sides can not be less than or equal to it's remaining side." if a+b <= c || a+c <= b || b+c <= a
	# triangle return logic		
	return :equilateral if a == b && b == c
	return :isosceles if (a == b && a != c) || (a == c && a != b) || (b == c && b != a)
	return :scalene if a != b && b != c
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
