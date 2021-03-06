# Additional data to be added for training

training_inputs = np.array([
        # 2010-03-16 (11 games)
        compare_two_teams(6, 12, 20092010),
        compare_two_teams(7, 11, 20092010),
        compare_two_teams(8, 3, 20092010),
        compare_two_teams(10, 9, 20092010),
        compare_two_teams(27, 14, 20092010),
        compare_two_teams(15, 13, 20092010),
        compare_two_teams(21, 19, 20092010),
        compare_two_teams(4, 18, 20092010),
        compare_two_teams(22, 30, 20092010),
        compare_two_teams(28, 25, 20092010),
        compare_two_teams(2, 23, 20092010),
        # 2011-03-15 (10 games)
        compare_two_teams(11, 1, 20102011),
        compare_two_teams(2, 3, 20102011),
        compare_two_teams(6, 29, 20102011),
        compare_two_teams(15, 8, 20102011),
        compare_two_teams(12, 7, 20102011),
        compare_two_teams(5, 9, 20102011),
        compare_two_teams(4, 13, 20102011),
        compare_two_teams(26, 18, 20102011),
        compare_two_teams(28, 25, 20102011),
        compare_two_teams(27, 20, 20102011),
        # 2012-03-17 (11 games)
        compare_two_teams(4, 6, 20112012),
        compare_two_teams(5, 1, 20112012),
        compare_two_teams(12, 30, 20112012),
        compare_two_teams(2, 8, 20112012),
        compare_two_teams(10, 9, 20112012),
        compare_two_teams(21, 3, 20112012),
        compare_two_teams(19, 14, 20112012),
        compare_two_teams(7, 13, 20112012),
        compare_two_teams(29, 23, 20112012),
        compare_two_teams(18, 26, 20112012),
        compare_two_teams(17, 28, 20112012),
        # 2013-03-16 (13 games)
        compare_two_teams(15, 6, 20122013),
        compare_two_teams(3, 5, 20122013),
        compare_two_teams(30, 21, 20122013),
        compare_two_teams(9, 7, 20122013),
        compare_two_teams(52, 10, 20122013),
        compare_two_teams(8, 1, 20122013),
        compare_two_teams(12, 14, 20122013),
        compare_two_teams(27, 29, 20122013),
        compare_two_teams(2, 13, 20122013),
        compare_two_teams(24, 19, 20122013),
        compare_two_teams(16, 25, 20122013),
        compare_two_teams(17, 23, 20122013),
        compare_two_teams(28, 26, 20122013),
        # 2014-03-18 (12 games)
        compare_two_teams(6, 1, 20132014),
        compare_two_teams(30, 2, 20132014),
        compare_two_teams(25, 5, 20132014),
        compare_two_teams(12, 29, 20132014),
        compare_two_teams(21, 8, 20132014),
        compare_two_teams(3, 9, 20132014),
        compare_two_teams(10, 17, 20132014),
        compare_two_teams(16, 4, 20132014),
        compare_two_teams(7, 20, 20132014),
        compare_two_teams(18, 22, 20132014),
        compare_two_teams(15, 24, 20132014),
        compare_two_teams(13, 28, 20132014),
        # 2015-03-14 (12 games)
        compare_two_teams(17, 4, 20142015),
        compare_two_teams(6, 5, 20142015),
        compare_two_teams(16, 28, 20142015),
        compare_two_teams(10, 23, 20142015),
        compare_two_teams(3, 7, 20142015),
        compare_two_teams(52, 14, 20142015),
        compare_two_teams(8, 2, 20142015),
        compare_two_teams(13, 12, 20142015),
        compare_two_teams(30, 19, 20142015),
        compare_two_teams(1, 53, 20142015),
        compare_two_teams(18, 26, 20142015),
        compare_two_teams(20, 21, 20142015),
        # 2016-03-19 (11 games)
        compare_two_teams(5, 4, 20152016),
        compare_two_teams(12, 30, 20152016),
        compare_two_teams(3, 28, 20152016),
        compare_two_teams(7, 10, 20152016),
        compare_two_teams(8, 9, 20152016),
        compare_two_teams(17, 13, 20152016),
        compare_two_teams(1, 29, 20152016),
        compare_two_teams(2, 25, 20152016),
        compare_two_teams(19, 23, 20152016),
        compare_two_teams(14, 53, 20152016),
        compare_two_teams(6, 26, 20152016),
        # 2017-03-16 (12 games)
        compare_two_teams(4, 1, 20162017),
        compare_two_teams(52, 2, 20162017),
        compare_two_teams(18, 15, 20162017),
        compare_two_teams(30, 12, 20162017),
        compare_two_teams(13, 29, 20162017),
        compare_two_teams(16, 9, 20162017),
        compare_two_teams(10, 14, 20162017),
        compare_two_teams(6, 22, 20162017),
        compare_two_teams(25, 23, 20162017),
        compare_two_teams(17, 53, 20162017),
        compare_two_teams(7, 26, 20162017),
        compare_two_teams(19, 28, 20162017),
        # 2018-03-17 (10 games)
        compare_two_teams(16, 7, 20172018),
        compare_two_teams(22, 13, 20172018),
        compare_two_teams(1, 26, 20172018),
        compare_two_teams(8, 10, 20172018),
        compare_two_teams(6, 14, 20172018),
        compare_two_teams(4, 12, 20172018),
        compare_two_teams(9, 29, 20172018),
        compare_two_teams(3, 19, 20172018),
        compare_two_teams(30, 53, 20172018),
        compare_two_teams(28, 23, 20172018),
])

training_outputs=np.array([[
# 20092010
        1,
        0,
        1,
        1,
        1,
        1,
        1,
        0,
        0,
        0,
        1,
# 20102011
        0,
        0,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
# 20112012
        0,
        1,
        1,
        1,
        1,
        1,
        1,
        0,
        0,
        0,
        0,
# 20122013
        0,
        0,
        1,
        1,
        1,
        1,
        0,
        0,
        1,
        0,
        1,
        1,
        0,
# 20132014
        1,
        1,
        0,
        1,
        0,
        1,
        0,
        0,
        0,
        0,
        1,
        1,
# 20142015
        0,
        1,
        1,
        0,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        0,
# 20152016
        1,
        0,
        0,
        0,
        0,
        1,
        0,
        0,
        1,
        1,
        0,
# 20162017
        0,
        1,
        1,
        0,
        0,
        1,
        1,
        0,
        1,
        1,
        0,
        1,
# 20172018
        0,
        1,
        1,
        0,
        1,
        1,
        0,
        0,
        1,
        1,
]]).T
