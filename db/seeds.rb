# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)


Factory( :workshop, :title => 'Encuadernación Artesanal', :short_description => 'con <strong>Paty Xacana</strong>, hilos y costuritas para libros.', :price => 115 )
Factory( :workshop, :title => 'Serigrafía Casera', :short_description => '"O cómo montarte un taller en casa" para imprimir de forma profesional tus propios diseños. Impartido por Vicius.', :price => 115 )
Factory( :workshop, :title => 'Fotografía Digital', :short_description => 'Curso para descubrir los secretos de la fotografía de la mano de <strong>Mats Karlsson</strong>.', :price => 115 )
Factory( :workshop, :title => 'Origami Sake', :short_description => 'Curso para aprender a bucear en los pliegues y dobleces, impartido por <strong>Desiréesán</strong>.', :price => 115 )
Factory( :workshop, :title => 'Taller de ilustración', :short_description => 'Dibujamos y aprendemos a contar historias con el gran ilustrador <strong>Eduardo Ortíz</strong>.', :price => 115 )
Factory( :workshop, :title => 'Taller de poesía breve', :short_description => 'Lo bueno si <strong>Ana Egea</strong>, dos veces bueno.', :price => 115 )
Factory( :workshop, :title => 'Taller de joyería experimental', :short_description => 'Materiales diversos, moldes y grabados. Impartido por <strong>Nines Villar</strong> que es una joya.', :price => 115 )
Factory( :workshop, :title => 'Taller de vídeo', :short_description => 'Haremos video por amor al arte! Edición básica con Final Cut. <strong>Cecilia Molano</strong>, alias Sexo, mentiras y cintas de video.', :price => 115 )
