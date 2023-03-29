#include <gtest/gtest.h>
#include "libB/B.h"

class ExampleTest: public ::testing::Test {
	public:
	
	virtual void SetUp(){}

	virtual void TearDown(){}
};

TEST_F(ExampleTest, TestOnePlusOne){
	EXPECT_DOUBLE_EQ(difference_double(1.0, 1.0), 0.0);
}

