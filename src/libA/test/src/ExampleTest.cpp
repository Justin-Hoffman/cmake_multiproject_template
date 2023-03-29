#include <gtest/gtest.h>
#include "libA/A.h"

class ExampleTest: public ::testing::Test {
	public:
	
	virtual void SetUp(){}

	virtual void TearDown(){}
};

TEST_F(ExampleTest, TestOnePlusOne){
	EXPECT_DOUBLE_EQ(sum_double(1.0, 1.0), 2.0);
}

