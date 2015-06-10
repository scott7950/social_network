function no_of_grow_models = get_no_of_grow_models(runFourGrowData, init_rand_vertices_conn, vertices_conn2, vertices_conn3, vertices_conn4)
if runFourGrowData == 1
    no_of_grow_models = 4;
else
    no_of_grow_models = 1;
end

if (size(vertices_conn2, 1) == size(init_rand_vertices_conn, 1)) || ...
        (size(vertices_conn3, 1) == size(init_rand_vertices_conn, 1)) || ...
        (size(vertices_conn4, 1) == size(init_rand_vertices_conn, 1))
    no_of_grow_models = 1;
end
