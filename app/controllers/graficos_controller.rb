class GraficosController < ApplicationController
  def index
  	data_array_1 = [1, 4, 3, 5, 9]
    data_array_2 = [4, 2, 10, 4, 7]

  	@bar0 = Gchart.bar(

            :size => '600x400',
            :bar_colors => ['000000', '0088FF'],
            :title => "grafica de Barra- Cantidad de mujeres y hombres por salon",
            :bg => 'EFEFEF',
            :legend => ['Mujeres ', 'Hombres'],
            :data => [[4, 2, 10, 4, 7],data_array_1],
            :stacked => true,
            :legend_position => 'bottom',
            :axis_with_labels => [['x'], ['y']],            
            :max_value => 15,
            :min_value => 0,
            :axis_labels => [["A|B|C|D|E"]],
            )                        
  end
end
