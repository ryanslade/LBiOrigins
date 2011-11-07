# Create departments

departments = ["Client Services", "Creative", "Delivery Management", "Managed Services", "Media", "Planning", "Technology", "Testing", "User Experience"]
departments.each { |e| Department.create(:name => e) }

